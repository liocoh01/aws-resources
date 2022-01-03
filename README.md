# Project Title

aws-resources

## Description

This Projects deploys via terraform vpc and a loadbalancer and network configuration.

## Getting Started

### Installing

* python3 -m venv env (installing virtual env)
* pip install -r requirements.txt

Deploying terraform modules for creating resources:
* invoke test
* invoke plan
* invoke apply

### Executing Python program

* listing all resources
```
python3 get_resources.py -o all
```

* describing all ec2 resources
```
python3 get_resources.py -o ec2
```

* describing all rds resources
```
python3 get_resources.py -o rds
```
