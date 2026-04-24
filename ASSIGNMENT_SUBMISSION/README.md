# Tech stack

## AWS Services

- CodeBuild
  - See `buildspec.yml` and `buildspec-base-image.yml` for details of the configured build process to generate Docker images.
  - *NOTE:* Purpose of `buildspec-base-image.yml` was to store a copy of the base image used in our Dockerfile to avoid rate limits pulling images on Docker Hub
  - *NOTE:* Attention on following configuration
    - Check, Enable this flag if you want to build Docker images or want your builds to get elevated privileges.
    - Building the application Docker images on aarch64 proved most successful. Issues when building for arm64 platform on x86_64.
    - Setup Github webhook to capture events for build triggers 
- AWS ECR
  - Private registry used to host our application Docker images
- AWS EKS
  - Node group configured with t4g.medium was cost effective and handle db load well
- AWS CloudWatch
  - Used Amazon CloudWatch Observability to easily propagate application logs to CloudWatch
- Docker
  - Build images for --platform linux/arm64
  - *NOTE:* Dockerfile located in `analytics` folder
- Python application
  - Tested with version 3.14.4 python
  - App dependencies in `requirements.txt` required updates to latest
- Postgresql
  - *NOTE:* Pinned to version 16
  - Version 16 is the latest version that worked out of box with the current deployment configurations and with the recent version of Python and app depdendencies.

# Other Gotchas

## Database deployment resources and helper files in db/deployment

_deploy.sh : 
    Requires setting an env PASSWORD for Postgresql password.

_seed-db.sh :
    Contains script to setup database and seed data.

## Application deployment

After verifying database deploy application config, secrets, and resources with `deployment/_deploy.sh`

Test endpoint that will verify db connection as well
    
    curl http://<service-dns>:5153/readiness_check

## AWS Lab

Overtime the EC2 instances that gets provision through the node group terminates. To recover manually, increase desired and max instances, then apply changes. Once the new instance appears, update the original desired and max to its original. Notice that existing deployments get restored.