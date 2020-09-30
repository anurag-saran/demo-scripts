#!/usr/bin/env bash

########################
# include the master
########################
. demo-master.sh
DEMO_PROMPT="${GREEN}anurags-MBP-2:os-demos anuragsaran$  ${BLACK}"
clear

pe "mvn io.quarkus:quarkus-maven-plugin:1.3.2.Final-redhat-00001:create \
    -DprojectGroupId=org.acme \
    -DprojectArtifactId=getting-started \
    -DplatformGroupId=com.redhat.quarkus \
    -DplatformVersion=1.3.2.Final-redhat-00001 \
    -DclassName=\"org.acme.quickstart.GreetingResource\" \
    -Dpath=\"hello\""
    
pe "cd getting-started"
pe "code ."
pe "mvn compile quarkus:dev"
pe "http://localhost:8080/hello"
pe "http://localhost:8080/hello"
pe "mvn package"
pe "ls -l target/*.jar"
pe "java -jar target/getting-started-1.0-SNAPSHOT-runner.jar"
pe "echo $GRAALVM_HOME"
pe "mvn clean package -Pnative -DskipTests=true"
pe "file target/getting-started-1.0-SNAPSHOT-runner"
pe "target/getting-started-1.0-SNAPSHOT-runner"
pe "ps -o pid,rss,command -p \$(pgrep -f runner)"
pe "curl http://localhost:8080/hello/greeting/quarkus"
pe "mvn quarkus:add-extension -Dextensions=\"openshift\""
pe "oc new-project quarkus --display-name=\"Sample Quarkus App\""
pe "mvn clean package -Pnative \
-Dquarkus.kubernetes-client.trust-certs=true \
-Dquarkus.container-image.build=true \
-Dquarkus.kubernetes.deploy=true \
-Dquarkus.kubernetes.deployment-target=openshift \
-Dquarkus.openshift.expose=true \
-Dquarkus.openshift.labels.app.openshift.io/runtime=java`"
pe "oc set resources dc/getting-started --limits=memory=50Mi"
pe "oc scale --replicas=10 dc/getting-started"
pe "for i in {1..50} ; do curl http://getting-started-quarkus.2886795276-80-simba07.environments.katacoda.com/hello/greeting/quarkus-on-openshift ; sleep .05 ; done"
pe "oc scale --replicas=100 dc/getting-started"






