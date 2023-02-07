#!/usr/bin/env sh
###############################################################################
# Copyright 2016 Intuit
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
###############################################################################
set -e

if [ "$1" = 'wasabi' ]; then
    cd /usr/local
    if [ "$USE_WASABI_ENV_CONFIGURATION" == "1" ]; then
       export WASABI_CONFIGURATION="-Ddatabase.url.host=${MYSQL_HOST} -Ddatabase.url.port=${MYSQL_PORT} -Ddatabase.url.dbname=${MYSQL_DATABASE} -Ddatabase.user=${MYSQL_USER} -Ddatabase.password=${MYSQL_PASSWORD} -Dusername=${CASSANDRA_USER} -Dpassword=${CASSANDRA_PASSWORD} -DnodeHosts=${CASSANDRA_HOST} -Dport=${CASSANDRA_PORT}  -DuseSSL=${CASSANDRA_USE_SSL} -DtokenAwareLoadBalancingLocalDC=${CASSANDRA_DATACENTER} -DkeyspaceName=${CASSANDRA_KEYSPACE}"
    fi
    exec ./${application.name}/bin/run "$@"
fi

exec "$@"