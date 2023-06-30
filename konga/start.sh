#!/bin/bash

POSTGRESQL_HOST=$1

# Wait for PostgreSQL to be ready
until pg_isready -h $POSTGRESQL_HOST -p 5432 -U $POSTGRESQL_USER; do
  echo "Waiting for PostgreSQL to be available..."
  sleep 1
done

# Run Konga
exec npm start