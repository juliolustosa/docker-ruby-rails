#!/bin/bash
set -e

## Configuration
ruby /scripts/config.rb

## Start Puma
bash /scripts/start-puma.sh