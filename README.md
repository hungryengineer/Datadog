# Overview
This repo will contain:
1. Datadog integration with kubernetes 
2. Based on a simple Java application
3. Fully automated using Github action pipeline and github packages as container repository
4. Additional components:
   1. Kafka
   2. RabbitMQ
   3. PostgreSql
   4. MongoDB
___________________________________________________________________
## Workflow of Datadog integration with Java application
1. Go to actions tab and execute the latest workflow store in the actions pipeline java-app-deployment.yaml
2. This will do the below:
    1. build the code
    2. create an image using the dockerfile 
    3. push the image into github packages 
    4. install the Java application using helm charts defined in the folder java-helm
3. After application deployment, execute the shell script "ddoperator-helm-setup.sh"

5. helm install datadog-agent -f datadog-values.yaml datadog/datadog

## RabbitMQ
1. Installation steps:
1. cd rabbitmq
2. kubectl apply -f cm.yaml,pv.yaml,rbac.yaml,secret.yaml,sts.yaml
3. Access the Management UI using the loadbalancer DNS appended with port 15672

## Apache Kafka
1. Installation steps:
1. cd kafka
2. kubectl apply -f netpol.yaml,zookeeper.yaml,kafka.yaml,pv.yaml
3. Testing of the setup:
1. k apply -f kcat.yaml
2.  kubectl exec -it kcat-pod-name -- bash
1. PUB:
echo "TEST" | kafkacat -b kafka:29092 -t newtopic123 -p -1
2. SUB:
kafkacat -C -b kafka:29092 -t newtopic123 -p -1


