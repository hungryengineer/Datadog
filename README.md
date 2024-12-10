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
_______________________________________________________________
## RabbitMQ
1. Installation steps:
    1. cd rabbitmq
    2. kubectl apply -f cm.yaml,pv.yaml,rbac.yaml,secret.yaml,sts.yaml
    3. Access the Management UI using the loadbalancer DNS appended with port 15672 using default Username: guest and Password: guest

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
________________________________________________________
## PostgreSQL
1. Installation steps:
    1. cd postgresql
    2. kubectl apply -f cm.yaml,deploy.yaml,pv.yaml,pvc.yaml,svc.yaml
    3. Testing of the DB setup:
     1. run a test pod with psql utilities: kubectl run postgres-client --image=postgres:10.1 -it --rm --restart=Never -- sh
     2. run the command: psql -h <postgres-service-name> -U <username> -d <database>
     3. CREATE DATABASE testdb;
     4. \l to list all dbs

_________________________________________________________

## MongoDB
1. Installation steps (using mongo kubernetes operator):
    1. helm repo add mongodb https://mongodb.github.io/helm-charts
    2. helm install atlas-operator --namespace=atlas-operator       --create-namespace mongodb/mongodb-atlas-operator
    3. helm install atlas-deployment \
        mongodb/atlas-deployment \
        --namespace=my-cluster \
        --create-namespace \
        --set atlas.secret.orgId='' \
        --set atlas.secret.publicApiKey='' \
        --set atlas.secret.privateApiKey='' \
        --values install-values.yaml
2. Check the status of the cluster and database using command:
    kubectl get atlasdeployment -n <namespace>
    If the deployment is not ready or any other issue, change the instance size to M0 (free tier) under spec using kubectl edit command
3. Testing the set-up:
   1. mongosh "mongodb+srv://myUser:<password>@myCluster.mongodb.net"
   2. use test
      db.myCollection.insert({ name: "MongoDB Atlas Operator Test" })
   3. db.myCollection.find()







 
