# Overview
This repo will contain:
1. Datadog integration with kubernetes 
2. Based on a simple Java application
3. Fully automated using Github action pipeline and github packages as container repository
___________________________________________________________________
# Workflow
1. Go to actions tab and execute the latest workflow store in the actions pipeline java-app-deployment.yaml
2. This will do the below:
    i) build the code
    ii) create an image using the dockerfile 
    iii) push the image into github packages 
    iv) install the Java application using helm charts defined in the folder java-helm
3. After application deployment, execute the shell script (helm-bash.sh) to automate the below steps:

# Helm installation steps:
1. helm repo add datadog https://helm.datadoghq.com
2. helm repo update
3. kubectl create secret generic datadog-secret --from-literal api-key=<DATADOG_API_KEY>

4. create a datadog-values.yaml with below snippet

registry: "gcr.io/datadoghq"
datadog:
  apm:
    socketEnabled: true
    hostSocketPath: /var/run/datadog/
    socketPath: /var/run/datadog/apm.socket
    portEnabled: true
    port: 8126 # default
  apiKeyExistingSecret: "datadog-secret"
  site: ""
  logs:
    enabled: true
    containerCollectAll: true
  serviceMonitoring:
    enabled: true
  networkMonitoring:
    enabled: true

5. helm install datadog-agent -f datadog-values.yaml datadog/datadog


