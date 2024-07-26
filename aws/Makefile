account_id := $(shell aws sts get-caller-identity | jq .Account | sed 's/"//g')

.PHONY: setup
setup:
	cd cloudformation && bash deploy.sh

.PHONY: init
init:
	terraform init \
		-backend-config="bucket=srs-terraform-state-storage-eu-west-1" \
		-backend-config="dynamodb_table=srs-terraform-state-storage-lock-eu-west-1"

.PHONY: plan
plan:
	$(if $(CLUSTER_NAME),,$(error CLUSTER_NAME is not set))
	$(if $(ENV),,$(error ENV is not set))
	terraform plan -out=tfplan -var="cluster_name=$(CLUSTER_NAME)" -var="env=$(ENV)"  

.PHONY: apply
apply:
	terraform apply tfplan

.PHONY: deploy
deploy:
	$(if $(CLUSTER_NAME),,$(error CLUSTER_NAME is not set))
	$(if $(ENV),,$(error ENV is not set))
	terraform plan -out=tfplan
	terraform apply tfplan

.PHONY: delete
delete:
	$(if $(CLUSTER_NAME),,$(error CLUSTER_NAME is not set))
	$(if $(ENV),,$(error ENV is not set))
	terraform plan -destroy -out=tfplan 
	terraform apply tfplan

.PHONY: eks-login
eks-login: $(HOME)/.kube/config

$(HOME)/.kube/config:
	$(if $(CLUSTER_NAME),,$(error CLUSTER_NAME is not set))
	aws eks update-kubeconfig --name $(CLUSTER_NAME)
