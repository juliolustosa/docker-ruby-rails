#!/bin/bash
APP_PUMA_CONFIG=$APP_HOME/config/puma.rb

# Start puma
if [ -f $APP_PUMA_CONFIG ]
then
  bundle exec puma -C $APP_PUMA_CONFIG
fi
