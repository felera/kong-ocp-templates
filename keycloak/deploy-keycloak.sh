#!/bin/bash
echo Deploying Keycloak and PostgreSQL:

if [ ! -f ./.env ]; then
    echo ".env file not found!"
    exit
fi

export $(cat .env | xargs)

postgres_database=$(echo -ne $postgres_database | base64);
postgres_user=$(echo -ne $postgres_user | base64);
postgres_password=$(echo -ne $postgres_password | base64);

oc new-project $openshift_project
oc apply -f keycloak.yml
oc new-app keycloak -p POSTGRES_USER=$postgres_user -p POSTGRES_PASSWORD=$postgres_password -p POSTGRES_DATABASE=$postgres_database -p KEYCLOAK_ADMIN=$KEYCLOAK_ADMIN -p KEYCLOAK_ADMIN_PASSWORD=$KEYCLOAK_ADMIN_PASSWORD -p APPLICATION_NAME=$APPLICATION_NAME -p HOSTNAME=$HOSTNAME

# KEYCLOAK_URL=https://$(oc get route keycloak --template='{{ .spec.host }}') &&
# echo "" &&
# echo "Keycloak:                 $KEYCLOAK_URL" &&
# echo "Keycloak Admin Console:   $KEYCLOAK_URL/admin" &&
# echo "Keycloak Account Console: $KEYCLOAK_URL/realms/myrealm/account" &&
# echo ""