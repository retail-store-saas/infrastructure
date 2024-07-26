ALB_SERVICE_ACCOUNT_CONFIG=../aws/aws-load-balancer-controller-service-account.yaml
EKS_HELM_CHARTS=https://aws.github.io/eks-charts

.PHONY: eks-login
eks-login: $(HOME)/.kube/config

$(HOME)/.kube/config:
	$(if $(CLUSTER_NAME),,$(error CLUSTER_NAME is not set))
	aws eks update-kubeconfig --name $(CLUSTER_NAME)

.PHONY: ecr-login
ecr-login:
	$(if $(AWS_ACCOUNT_ID),,$(error AWS_ACCOUNT_ID is not set))
	aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin $(AWS_ACCOUNT_ID).dkr.ecr.${AWS_REGION}.amazonaws.com

# https://docs.aws.amazon.com/eks/latest/userguide/aws-load-balancer-controller.html
.PHONY: configure-alb-controller
configure-alb-controller: $(HOME)/.kube/config
	kubectl apply -f $(ALB_SERVICE_ACCOUNT_CONFIG)
	helm repo add eks $(EKS_HELM_CHARTS)
	helm repo update
	helm upgrade --install aws-load-balancer-controller eks/aws-load-balancer-controller \
		-n kube-system \
		--set clusterName=$(CLUSTER_NAME) \
		--set serviceAccount.create=false \
		--set serviceAccount.name=aws-load-balancer-controller

SNYK_MONITOR_HELM_CHARTS=https://snyk.github.io/kubernetes-monitor

.PHONY: configure-k8s-integration
configure-k8s-integration: $(HOME)/.kube/config
	helm repo add snyk-charts $(SNYK_MONITOR_HELM_CHARTS) --force-update
	helm repo update
	kubectl apply -f snyk-monitor/ns.yaml
	kubectl apply -f snyk-monitor/secret.yaml \
		-n snyk-monitor 	
	helm upgrade --install snyk-monitor snyk-charts/snyk-monitor \
		--namespace snyk-monitor 

