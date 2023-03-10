#!/bin/bash
set -e


if ! bundle check 
then
  bundle install;
fi

# Remove a potentially pre-existing server.pid for Rails.
rm -f /app/tmp/pids/server.pid
bundle exec rails db:migrate
# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"
