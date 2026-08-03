#!/usr/bin/env python3
import os
import socket
import http.client
from pathlib import Path
from datetime import datetime


LOG_DIR = Path("/workspace")
LOG_FILE = LOG_DIR / "pod_startup.log"

UP_CODES = {200, 301, 302, 401, 403, 404}  # "up but protected/redirect" is still UP
SERVICES = {
    "Code-Server": 9000,
    "ComfyUI": 8188,
}


def ts() -> str:
    return datetime.now().strftime("%Y-%m-%d %H:%M:%S")


def write(line: str) -> None:
    print(line)
    with LOG_FILE.open("a", encoding="utf-8") as f:
        f.write(line + "\n")


def log(line: str) -> None:
    write(f"[{ts()}] {line}")


def print_var(var: str, width: int = 25) -> None:
    value = os.environ.get(var, "<not set>")
    write(f"{var:<{width}} = {value}")


def http_check_local(port: int, path: str = "/", timeout: float = 2.0):
    """
    Returns: (is_up: bool, http_code: int|None, detail: str)
    """
    # First: fast TCP connect check (helps distinguish "connection refused" quickly)
    try:
        with socket.create_connection(("127.0.0.1", port), timeout=timeout):
            pass
    except Exception as e:
        return False, None, f"TCP connect failed: {e}"

    # Second: HTTP GET
    try:
        conn = http.client.HTTPConnection("127.0.0.1", port, timeout=timeout)
        conn.request("GET", path)
        resp = conn.getresponse()
        code = resp.status
        resp.read()  # consume
        conn.close()
        return (code in UP_CODES), code, "HTTP ok"
    except Exception as e:
        return False, None, f"HTTP request failed: {e}"


def main() -> None:
    LOG_DIR.mkdir(parents=True, exist_ok=True)

    log("🚀 RunPod Pod startup environment")
    log("--------------------------------")

    # === Core Pod info ===
    for v in ("RUNPOD_POD_ID", "RUNPOD_DC_ID", "RUNPOD_POD_HOSTNAME"):
        print_var(v)

    # === Resources ===
    for v in ("RUNPOD_GPU_COUNT", "RUNPOD_CPU_COUNT", "CUDA_VERSION", "PYTORCH_VERSION"):
        print_var(v)

    # === Networking ===
    for v in ("RUNPOD_PUBLIC_IP", "RUNPOD_TCP_PORT_22", "RUNPOD_ALLOW_IP"):
        print_var(v)

    # === Storage & access ===
    for v in ("RUNPOD_VOLUME_ID", "PUBLIC_KEY"):
        print_var(v)

    # === API ===
    print_var("RUNPOD_API_KEY")

    # === Runtime ===
    print_var("PWD")

    log("--------------------------------")
    log("🔎 All RUNPOD_* environment variables (auto-detected)")
    log("--------------------------------")

    for key in sorted(k for k in os.environ if k.startswith("RUNPOD_")):
        value = os.environ.get(key, "")
        if any(x in key.upper() for x in ("KEY", "TOKEN", "SECRET", "PASSWORD")):
            value = "<redacted>"
        write(f"{key:<30} = {value}")

    log("--------------------------------")
    log("🩺 Service checks (inside pod)")
    log("--------------------------------")

    pod_id = os.environ.get("RUNPOD_POD_ID", "").strip()
    for name, port in SERVICES.items():
        proxy_url = f"https://{pod_id}-{port}.proxy.runpod.net/" if pod_id else "<RUNPOD_POD_ID not set>"
        local_url = f"http://127.0.0.1:{port}/"

        write(f"🔗 {name:<12} proxy: {proxy_url}")
        write(f"   {name:<12} local: {local_url}")

        is_up, code, detail = http_check_local(port, path="/", timeout=2.0)
        if is_up:
            write(f"✅ {name} is running (HTTP {code})")
        else:
            code_str = str(code) if code is not None else "-"
            write(f"❌ {name} not ready (HTTP {code_str}) — {detail}")

    log("--------------------------------")
    log("✅ RunPod environment logging complete")


if __name__ == "__main__":
    main()