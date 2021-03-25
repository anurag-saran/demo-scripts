#!/usr/bin/env bash

########################
# include the master
########################
. ./demo-master.sh

clear

pe "oc delete project amex-kafkaevents"
pe "oc new-project amex-kafkaevents"

pe "oc apply -f knative/eventing/my-newkafka-source.yaml"

pe "kn sources ls"
pe "kn service create eventinghello --namespace amex-kafkaevents --concurrency-target=1 --image=quay.io/rhdevelopers/eventinghello:0.0.2"
pe "oc get po"
pe "oc run kafka-producer -ti --image=registry.redhat.io/amq7/amq-streams-kafka-26-rhel7:1.6.0 --rm=true --restart=Never -- bin/kafka-console-producer.sh --broker-list my-cluster-kafka-bootstrap.amex-kafka:9092 --topic my-topic"
# in a different terminal
#% stern eventinghello -c user-container
