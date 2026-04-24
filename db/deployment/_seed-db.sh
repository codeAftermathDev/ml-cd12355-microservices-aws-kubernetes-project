#!/usr/bin/env bash

set -e -x

kubectl port-forward service/postgresql-service 5433:5432 &

sleep 3 # Give some time for port-forwarding to establish

echo "Creating tables and seeding database ..."
psql --host 127.0.0.1 -U udacity -d udacity -p 5433 < ../1_create_tables.sql
psql --host 127.0.0.1 -U udacity -d udacity -p 5433 < ../2_seed_users.sql
psql --host 127.0.0.1 -U udacity -d udacity -p 5433 < ../3_seed_tokens.sql

# Closes all port forwards
echo "Closing port forwards ..."
ps aux | grep 'kubectl port-forward' | grep -v grep | awk '{print $2}' | xargs -r kill