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

# Batch for civitai downloads.

if [[ ! -f /workspace/batch.txt ]]
then
	mv /batch.txt /workspace/batch.txt
else
	rm -f /batch.txt
fi