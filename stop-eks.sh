#!/bin/bash
set -e
set -x
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]:-$0}"; )" &> /dev/null && pwd 2> /dev/null; )";

for i in $SCRIPT_DIR/common/scripts/*;
  do source $i
done

parse_args $@

echo $profile
kubectl delete  -k .
#echo kubectl apply -f keycloak.yml ${envargs}