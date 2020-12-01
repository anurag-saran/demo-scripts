#!/usr/bin/env bash

########################
# include the master
########################
. demo-master.sh
DEMO_PROMPT="${GREEN}anurags-MBP-2:os-demos anuragsaran$  ${BLACK}"
clear
#pe "oc delete namespace amex-kafka"
pe "oc project amex-kafka"
pe "kn source list-types"
pe "kubectl api-resources --api-group='messaging.knative.dev'"
pe "cat knative/eventing/default-channel-config.yaml"
#pe "oc apply -f knative/eventing/default-channel-config.yaml"
pe "kn channel create my-events-ch \
  --namespace amex-kafka"
pe "kn channel -n amex-kafka ls"
pe "kubectl get -n kafka kafkatopics"
pe "kn service create eventinghello \
  --namespace amex-kafka \
  --concurrency-target=1 \
  --image=quay.io/rhdevelopers/eventinghello:0.0.2"
pe "kn service ls"
pe "kubectl apply -n kafka \
  -f knative/eventing/kafka-topic-my-topic.yaml"
pe "kubectl get -n kafka kafkatopics"
pe "cat knative/eventing/mykafka-source.yaml"
pe "kubectl -n amex-kafka apply -f knative/eventing/mykafka-source.yaml"
pe "kn sources -n amex-kafka ls"
p "stern eventinghello -c user-container"
pe "./knative/bin/kafka-producer.sh"

#kn service delete eventinghello
#kubectl delete -n amex-kafka -f knative/eventing/kafka-topic-my-topic.yaml
#kubectl delete -n kafka -f knative/eventing/kafka-topic-my-topic.yaml
#kubectl delete -n amex-kafka  -f knative/eventing/mykafka-source.yaml
#kn channel delete -n amex-kafka my-events-ch
#kubectl delete -n amex-kafka pod kafka-spammer
#kubectl delete -n amex-kafka  -f knative/eventing/eventing-hello-sink.yaml


  
 