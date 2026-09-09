#!/bin/bash

# Ensure we have /workspace in all scenarios
mkdir -p /workspace

# Readme

if [[ ! -f /workspace/README.md ]]
then
	mv /README.md /workspace/README.md
else
	rm -f /README.md
fi

# Healthcheck test.

if [[ ! -f /workspace/runpod-healthcheck.sh ]]
then
	mv /runpod-healthcheck.sh /workspace/runpod-healthcheck.sh
else
	rm -f /runpod-healthcheck.sh
fi