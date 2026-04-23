# Notes

## Postgresql

**NOTE**: Pinned to container version 16 instead of latest to support original forked implementation.

```sh
# Applying configurations for setting up Postgresql in Kubernetes
kubectl apply -f pvc.yaml
kubectl apply -f pv.yaml
# Note that db parameters is being set in postgresql-deployment.yaml
    # POSTGRES_DB
    # POSTGRES_USER
    # POSTGRES_PASSWORD
kubectl apply -f postgresql-deployment.yaml
# Alternatively, set the passwork as env var and use the following substitution
export DB_PASSWORD=mypassword
PASSWORD=DB_PASSWORD=${PASSWORD} envsubst < postgresql-deployment.yaml | kubectl apply -f -

# Verify EKS DB setup
kubectl get pods # Fetch POD_ID for postgres from this command output
kubectl exec -it <POD_ID> -- bash
# Within container shell
psql -U myuser -d mydatabase

# Forwarding request from local env to Postgresql instance
# List the services
kubectl get svc

# Set up port-forwarding to `postgresql-service`
# --address 0.0.0.0 Allows traffic from within container for testing
kubectl port-forward --address 0.0.0.0 service/postgresql-service 5433:5432 &
# To disable all port-forwarding
ps aux | grep 'kubectl port-forward' | grep -v grep | awk '{print $2}' | xargs -r kill

# Seed the DB with include sql files
export DB_PASSWORD=mypassword
PASSWORD="$DB_PASSWORD" psql --host 127.0.0.1 -U udacity -d udacity -p 5433 < FILENAME.sql

# Connect to DB from local environment to 
PASSWORD="$DB_PASSWORD" psql --host 127.0.0.1 -U udacity -d udacity -p 5433

# Some psql commands
\l              # list databases
\dt             # list tables
\dt public.*    # list tables in public
\q              # quit psql 
```

## Analytics App

**NOTE**: Updated app dependency versions to the latest at this moment to support Python 3.14.x

```
# Install app dependencies
apt install build-essential libpq-dev # Needed by python dependencies
pip install -r requirements.txt

# Set the following environment variables
    export DB_USERNAME=udacity
    export DB_PASSWORD=${POSTGRES_PASSWORD}
    export DB_HOST=127.0.0.1                # Testing app on local environment
    #export DB_HOST=host.docker.internal    # Testing app in container
    export DB_PORT=5433
    export DB_NAME=udacity

# Run application
python app.py

# Test with curl command - Ensure port-forward set for Postgresql
curl 127.0.0.1:5433/readiness_check
curl 127.0.0.1:5433/api/reports/user_visits
```