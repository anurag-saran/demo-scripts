#!/usr/bin/env bash

########################
# include the master
########################
. demo-master.sh
DEMO_PROMPT="${GREEN}anurags-MBP-2:os-demos anuragsaran$  ${BLACK}"
clear
pe "oc delete namespace amexevent-brokerstrig"
pe "oc new-project amexevent-brokerstrig"
pe "kn broker create default \
  --namespace amexevent-brokerstrig"
pe "kn broker -n amexevent-brokerstrig list"
pe "kn service create eventingaloha \
  --namespace amexevent-brokerstrig \
  --concurrency-target=1 \
  --revision-name=eventingaloha-v1 \
  --image=quay.io/rhdevelopers/eventinghello:0.0.2"
pe "kn service create eventingbonjour \
  --namespace amexevent-brokerstrig \
  --concurrency-target=1 \
  --revision-name=eventingbonjour-v1 \
  --image=quay.io/rhdevelopers/eventinghello:0.0.2"
pe "kn trigger create helloaloha \
  --namespace amexevent-brokerstrig \
  --broker=default \
  --sink=ksvc:eventingaloha \
  --filter=type=greeting"
pe "kn trigger create hellobonjour \
  --namespace amexevent-brokerstrig \
  --broker=default \
  --sink=ksvc:eventingbonjour \
  --filter=type=greeting"
pe "kn trigger list --namespace amexevent-brokerstrig"

#kubectl get trigger helloaloha -o jsonpath='{.status.subscriberUri}'
#kubectl get trigger hellobonjour -o jsonpath='{.status.subscriberUri}'
#kubectl get broker default -o jsonpath='{.status.address.url}'
#stern eventing -c user-container
pe "kubectl -n amex-brokers-triggers apply -f knative/eventing/curler.yaml"
pe "kubectl -n amex-brokers-triggers exec -it curler -- /bin/bash"
curl -v "http://eventingaloha.amexevent-brokerstrig.svc.cluster.local" \
-X POST \
-H "Ce-Id: say-hello" \
-H "Ce-Specversion: 1.0" \
-H "Ce-Type: aloha" \
-H "Ce-Source: mycurl" \
-H "Content-Type: application/json" \
-d '{"key":"from a curl"}'
curl -v "http://eventingbonjour.amexevent-brokerstrig.svc.cluster.local" \
-X POST \
-H "Ce-Id: say-hello" \
-H "Ce-Specversion: 1.0" \
-H "Ce-Type: bonjour" \
-H "Ce-Source: mycurl" \
-H "Content-Type: application/json" \
-d '{"key":"from a curl"}'
curl -v "http://broker-ingress.knative-eventing.svc.cluster.local/amexevent-brokerstrig/default" \
-X POST \
-H "Ce-Id: say-hello" \
-H "Ce-Specversion: 1.0" \
-H "Ce-Type: greeting" \
-H "Ce-Source: mycurl" \
-H "Content-Type: application/json" \
-d '{"key":"from a curl"}'
 
