# docker-smashing

This sample project contains the minimal structure for a Ruby Smashing application
deployment. Based on the work done in [this repo](https://github.com/atilleh/docker-smashing)


## How to use

Clone the repository:
```
git clone git@github.com:ruijzndl/docker-smashing.git docker-smashing
```
Move into the cloned repository:
```
cd docker-smashing
```

Create environment variables to match with your information:
```
(nano, vim) .env:


SMASHING_KEY=9876-543210-2
AWS_DEFAULT_REGION=eu-west-1
AWS_ACCESS_KEY_ID=AKIRVSPIMUUNBCOVIDPNA
AWS_SECRET_ACCESS_KEY=yNgSendVzLERincI7/thelH2WkClownyUWoahR

```

Create the basic Smashing directories structure:
```
docker-compose run smashing smashing new .
```

Launch Smashing to check if everything is fine:
```
docker-compose up
```


## Set the Smashing API key

Update SMASHING_KEY API key in .env file or as SMASHING_KEY environment variable:
When done in .env file, docker-compose file will take care of handing over the
API key to the smashing container. When used as a standalone docker container
the environment variable SMASHING_KEY needs to be set in for the container.
The inject-secrets.sh scrip is part of the container startup procedure and will
inject the API key into the confg.ru folder of the smashing container.
