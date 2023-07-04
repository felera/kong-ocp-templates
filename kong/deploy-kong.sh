#!/bin/bash
echo Deploying Kong and PostgreSQL:

if [ ! -f ./.env ]; then
    echo ".env file not found!"
    exit
fi

export $(cat .env | xargs)

postgres_database=$(echo -ne $postgres_database | base64);
postgres_user=$(echo -ne $postgres_user | base64);
postgres_password=$(echo -ne $postgres_password | base64);

oc new-project $openshift_project
oc apply -f kong-pg-ocp-template.yml
oc new-app kong-template -p postgres_user=$postgres_user -p postgres_password=$postgres_password -p postgres_database=$postgres_database