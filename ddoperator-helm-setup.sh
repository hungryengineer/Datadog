#!/bin/bash

# Step 1: Add the Helm repository for Datadog
helm repo add datadog https://helm.datadoghq.com
helm repo update

# Step 2: Install the Datadog Operator Helm chart
kubectl create namespace datadog-system || echo "Namespace datadog-system already exists"
helm install datadog-operator datadog/datadog-operator --namespace datadog-system

# Step 3: Prompt user for the Datadog API Key
read -sp "Enter Datadog API Key: " DATADOG_API_KEY

# Create Kubernetes secret for Datadog API key
kubectl create secret generic datadog-secret --from-literal=api-key=$DATADOG_API_KEY --namespace datadog-system || echo "Datadog secret already exists, replacing..."
kubectl delete secret datadog-secret --namespace datadog-system 2>/dev/null && \
  kubectl create secret generic datadog-secret --from-literal=api-key=$DATADOG_API_KEY --namespace datadog-system

# Step 4: Prompt user for the Datadog "site" value
read -p "Enter the Datadog site (e.g., us5.datadoghq.com): " DATADOG_SITE

# Create or overwrite datadog-values.yaml with provided content
cat <<EOL > datadog-values.yaml
registry: "gcr.io/datadoghq"
datadog:
  apm:
    socketEnabled: true
    hostSocketPath: /var/run/datadog/
    socketPath: /var/run/datadog/apm.socket
    portEnabled: true
    port: 8126 # default
  apiKeyExistingSecret: "datadog-secret"
  site: "$DATADOG_SITE"
  logs:
    enabled: true
    containerCollectAll: true
  serviceMonitoring:
    enabled: true
  networkMonitoring:
    enabled: true
EOL

# Step 5: Deploy the Datadog Agent using the created values file
helm install datadog-agent datadog/datadog -f datadog-values.yaml --namespace datadog-system
