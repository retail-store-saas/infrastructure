# Access instructions

## AWS

Prerequisites:
  - [aws cli](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
  - [aws-vault](https://github.com/99designs/aws-vault) cli

The `breakglass_administrator` has been provisioned

The access token is stored in group 1password vault. [link](https://start.1password.com/open/i?a=PVJXHTLBRZAU5B6AZPH4R2XPKY&v=gk27o6sn2vmcbfdgbr6tplm6x4&i=76zn6m3ae5crjmqo44kvefvcya&h=team-snyk.1password.com)

Add the credential to `aws-vault`

```
aws-vault add retail-store-saas-prod
```

Login to the account

```
aws-vault login retail-store-saas-prod
```

Use aws cli

```
aws-vault exec retail-store-saas-prod --
```


## Kubernetes

Kubernetes cluster is managed via EKS

Obtain kubeconfig entry

```
aws-vault exec retail-store-saas-prod --
aws eks update-kubeconfig --name srs-prod
```

Use default kubernetes client

```
kubectl get pods
```
