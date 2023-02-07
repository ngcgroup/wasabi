#!/bin/bash
set -e
set -x
#!/bin/bash
set -e
set -x
project=bhn_experiments
cassandra=cassandra:4.1.0
mysql=mysql:5.6
img_version=latest


fromPom() {
    mvn ${WASABI_MAVEN} -f $1/pom.xml -P $2 help:evaluate -Dexpression=$3 | sed -n -e '/^\[.*\]/ !{ p; }'
}


id=$(fromPom modules/main development application.name)

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]:-$0}"; )" &> /dev/null && pwd 2> /dev/null; )";

for i in $SCRIPT_DIR/common/scripts/*;
  do source $i
done

parse_args $@
source_env_from_aws


#docker build -t keycloak . -f Dockerfile-${kc_version}
registry=982306614752.dkr.ecr.us-west-2.amazonaws.com
server_tag=$registry/experimentation-server:${img_version}
ui_tag=$registry/experimentation-ui:${img_version}
migration_tag=$registry/experimentation-migration:${img_version}
docker build -t ${server_tag} -f modules/main/target/${id}/Dockerfile modules/main/target/${id}
docker build -t ${ui_tag} -f modules/main/target/${id}/Dockerfile.webapp modules/main/target/${id}
docker build -t ${migration_tag}  -f "./bin/docker/migration.docker" "."
docker_login $registry
docker_push ${server_tag}
docker_push ${ui_tag}
docker_push ${migration_tag}
#if [ "$docker_login" == "true" ];then
#	aws ecr get-login-password --region us-west-2 | docker login --username AWS --password-stdin 982306614752.dkr.ecr.us-west-2.amazonaws.com
#fi
#if [ "$docker_push" == "true" ];then
#	docker push 982306614752.dkr.ecr.us-west-2.amazonaws.com/keycloak:latest
#fi