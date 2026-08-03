#!/bin/bash

# Ensure we have /workspace in all scenarios
mkdir -p /workspace

if [[ ! -d /workspace/docs ]]
then
	mv /docs /workspace
	# Set permissions right for directory
    chmod -R 777 /workspace/docs
else
	rm -rf /docs
fi

# Linking
ln -s /workspace/docs /docs
