#!/bin/bash

set -e

aws cloudformation deploy --capabilities CAPABILITY_NAMED_IAM --template-file ./terraform-storage-stack.yaml --stack-name terraform-storage --region eu-west-1
