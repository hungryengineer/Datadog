# Overview
This repo will contain:
1. Datadog integration with kubernetes 
2. Based on a simple Java application
3. Fully automated using Github action pipeline and github packages as container repository
4. Additional components:
   i) Kafka
   ii) RabbitMQ
   iii) PostgreSql
   iv) MongoDB
___________________________________________________________________
## Workflow of Datadog integration with Java application
1. Go to actions tab and execute the latest workflow store in the actions pipeline java-app-deployment.yaml
2. This will do the below:
    i) build the code
    ii) create an image using the dockerfile 
    iii) push the image into github packages 
    iv) install the Java application using helm charts defined in the folder java-helm
3. After application deployment, execute the shell script "ddoperator-helm-setup.sh"

5. helm install datadog-agent -f datadog-values.yaml datadog/datadog

## RabbitMQ
1. Installation steps:
i) cd rabbitmq
ii) kubectl apply -f cm.yaml,pv.yaml,rbac.yaml,secret.yaml,sts.yaml
iii) Access the Management UI using the loadbalancer DNS appended with port 15672

## Apache Kafka



