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
# Workflow
1. Go to actions tab and execute the latest workflow store in the actions pipeline java-app-deployment.yaml
2. This will do the below:
    i) build the code
    ii) create an image using the dockerfile 
    iii) push the image into github packages 
    iv) install the Java application using helm charts defined in the folder java-helm
3. After application deployment, execute the shell script
    enabled: true
  networkMonitoring:
    enabled: true

5. helm install datadog-agent -f datadog-values.yaml datadog/datadog


