#!/usr/bin/env bash

########################
# include the master
########################
. ./demo-master.sh

clear

pe "oc delete project amex-functions"
pe "oc new-project amex-functions"
pe "rm -rf quarkus-func"
pe "kn func create quarkus-func -l quarkus"
#  docker login quay.io
pe "cd quarkus-func"
pe "kn func deploy -r quay.io/nandanj -n amex-functions -v"
pe "kn func list"
echo "curl -d '{"message":"American"}' -H "Content-Type: application/json" http://quarkus--func-amex-functions.apps.cluster-86ec.86ec.sandbox1639.opentlc.com"
curl -d '{"message":"American"}' -H "Content-Type: application/json" http://quarkus--func-amex-functions.apps.cluster-86ec.86ec.sandbox1639.opentlc.com
echo "\ncurl -d '{"message":"Express"}' -H "Content-Type: application/json" http://quarkus--func-amex-functions.apps.cluster-86ec.86ec.sandbox1639.opentlc.com"
curl -d '{"message":"Express"}' -H "Content-Type: application/json" http://quarkus--func-amex-functions.apps.cluster-86ec.86ec.sandbox1639.opentlc.com
