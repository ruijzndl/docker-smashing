# Cesar-AWS-Dashboard

This repo contains the code for the cesar-aws status dashboard.
It was build using a Ruby Smashing application. The work on this
repo was based on the work done [here](https://github.com/atilleh/docker-smashing)


## How to use

Clone the repository:
```
git@github.com:philips-internal/cesar-aws-dashboard.git
```
Move into the cloned repository:
```
cd cesar-aws-dashboard
```

Create .env file and update environment variables to match with your information:
```
(nano, vim) .env:


SMASHING_KEY=9876-543210-2
AWS_DEFAULT_REGION=eu-west-1
AWS_ACCESS_KEY_ID=AKIRVSPIMUUNBCOVIDPNA
AWS_SECRET_ACCESS_KEY=yNgSendVzLERincI7/thelH2WkClownyUWoahR

```

Launch Smashing to check if everything is fine:
```
docker-compose up
```
