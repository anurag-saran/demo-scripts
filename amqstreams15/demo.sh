#!/usr/bin/env bash

########################
# include the master
########################
. demo-master.sh
DEMO_PROMPT="${GREEN}anurags-MBP-2:os-demos anuragsaran$  ${BLACK}"
clear

pe "oc new-project amq-streams"
pe "oc apply -f install/cluster-operator"
pe "cat ../configurations/clusters/simple-cluster.yaml"
pe "oc apply -f ../configurations/clusters/simple-cluster.yaml"
pe "oc rsh simple-cluster-kafka-0"
#pe "bin/kafka-console-producer.sh --broker-list localhost:9092 --topic test-topic"
#pe "oc rsh simple-cluster-kafka-0"
#pe "bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic test-topic --from-beginning"
pe "oc get kafka simple-cluster -o yaml"
pe "oc get kafka"
pe "oc delete kafka simple-cluster"
pe "cat ../configurations/clusters/production-ready.yaml"
pe "oc apply -f ../configurations/clusters/production-ready.yaml"
pe "oc get pvc"
pe "cat ../configurations/clusters/production-ready-5-nodes.yaml"
pe "oc apply -f ../configurations/clusters/production-ready-5-nodes.yaml"
pe "oc apply -f ../configurations/clusters/production-ready.yaml"
pe "oc get pvc"
pe "cat ../configurations/topics/lines.yaml"
pe "oc apply -f ../configurations/topics/lines.yaml"
pe "oc rsh production-ready-kafka-0"
#pe "bin/kafka-topics.sh --zookeeper localhost:2181 --topic lines --describe"
pe "oc apply -f ../configurations/topics/lines-10.yaml"
pe "oc rsh production-ready-kafka-0"
#pe "bin/kafka-topics.sh --zookeeper localhost:2181 --topic lines --describe"
pe "cat ../configurations/clusters/production-ready-secured.yaml"
pe "oc apply -f ../configurations/clusters/production-ready-secured.yaml"
pe "cat ../configurations/users/secure-topic-reader.yaml"
pe "oc apply -f ../configurations/users/secure-topic-reader.yaml"
pe "cat ../configurations/clusters/production-ready-monitored.yaml"
pe "oc apply -f ../configurations/clusters/production-ready-monitored.yaml"
pe "oc apply -f ../configurations/metrics/prometheus.yaml"
pe "oc expose svc prometheus"
pe "oc apply -f ../configurations/metrics/grafana.yaml"
pe "oc expose svc grafana"
# https://master.paris-ead4.open.redhat.com/console/project/amq-streams/overview
# opentlc-mgr / r3dh4t1!
# https://console-openshift-console.apps.cluster-chicago-56e5.chicago-56e5.sandbox37.opentlc.com/dashboards
# admin / r3dh4t1!
# https://raw.githubusercontent.com/strimzi/strimzi-kafka-operator/0.11.1/metrics/examples/grafana/strimzi-kafka.json
# https://docs.google.com/presentation/d/1t85CMa5WsT8CzpQ5BKVMAFyIR8qxf2wQbkxNlg7176Q/edit#slide=id.g98113c6136_4_200
# https://access.redhat.com/articles/3188232
# https://access.redhat.com/articles/2791941





