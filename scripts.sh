# DEPLOY POSTGRESQL AND KONG PROXY
oc apply -f kong-pg-ocp-template.yml
oc new-app kong-template -p postgres_user=a29uZw== -p postgres_password=a29uZw== -p postgres_database=a29uZw==

#DEPLOY KONGA

DOCKER_CONFIG_JSON=$(cat ~/.docker/config.json | base64 -w0)
oc process -f konga-mongodb-v2.yml -p DOCKER_CONFIG_JSON=$DOCKER_CONFIG_JSON -p POSTGRESQL_USER=konga -p POSTGRESQL_PASSWORD=konga -p POSTGRESQL_DATABASE=kongadb | oc apply -f -

oc apply -f konga/konga-deployment-template.yaml
oc process konga-deployment-template \
  -p GITHUB_REPOSITORY_URL=https://github.com/felera/kong-ocp-templates \
  -p GITHUB_CONTEXT_DIR=konga \
  -p BRANCH_NAME=konga \
  -p POSTGRESQL_USER=konga \
  -p POSTGRESQL_PASSWORD=konga \
  -p POSTGRESQL_DATABASE=kongadb \
  -p NODE_ENV=development \
  | oc apply -f -


oc new-app https://github.com/felera/kong-ocp-templates#konga --context-dir=konga
