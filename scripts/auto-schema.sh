#!/bin/bash
APP_DB_SCHEMA=$APP_HOME/db/schema.rb
TMP_DB_SCHEMA=/tmp/db/schema.rb

mkdir -p /tmp/db

# Check Schema
if [ -f $TMP_DB_SCHEMA ]
then
  if ! diff -q $APP_DB_SCHEMA $TMP_DB_SCHEMA >/dev/null
  then
    bundle exec rake db:migrate
    cp $APP_DB_SCHEMA $TMP_DB_SCHEMA
  fi
else
  bundle exec rake db:create
  bundle exec rake db:migrate
  cp $APP_DB_SCHEMA $TMP_DB_SCHEMA
fi
