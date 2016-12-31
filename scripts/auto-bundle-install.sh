#!/bin/bash

APP_GEMFILE=$APP_HOME/Gemfile
APP_GEMFILE_LOCK=$APP_HOME/Gemfile.lock
TMP_GEMFILE=/tmp/Gemfile

source /auto-bundle-install.lib

# Auto bundle install
if [ -f $TMP_GEMFILE ]
then
  modified
else
  gemfile
fi
