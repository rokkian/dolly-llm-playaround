#!/bin/bash

set -ex # e: exits on first error, x: print commands

ls
cd /home
ls
touch tmp || echo "failed to touch tmp" # || pipe lets run the second command if the first fails
