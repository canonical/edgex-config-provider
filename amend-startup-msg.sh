#!/bin/bash

# This script is to replace the Startup Message from default config files to
# ease testing.

path=$1

find $path -type f -name 'configuration.yaml' | xargs \
    sed --in-place --regexp-extended \
    's/StartupMsg.*/StartupMsg: CONFIG BY EXAMPLE PROVIDER/'
