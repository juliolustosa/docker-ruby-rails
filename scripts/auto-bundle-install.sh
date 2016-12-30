#!/bin/bash

APP_GEMFILE=$APP_HOME/Gemfile
APP_GEMFILE_LOCK=$APP_HOME/Gemfile.lock
APP_PUMA_CONFIG=$APP_HOME/config/puma.rb
TMP_GEMFILE=/tmp/Gemfile

source /auto-bundle-install.lib

# Auto bundle install
if [ -f $TMP_GEMFILE ]
then
  modified
else
  gemfile
fi

# Start puma
if [ -f $APP_PUMA_CONFIG ]
then
  bundle exec puma -C $APP_PUMA_CONFIG
fi
