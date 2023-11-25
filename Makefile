create-kind-cluster:
	kind create cluster --config=./kind-install/cluster-nodeport.yaml --image kindest/node:v1.27.3

deploy-ingress-controller:
	kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.9.4/deploy/static/provider/kind/deploy.yaml

deploy-argo-kind-cluster:
	helm repo update argo 
	helm upgrade --install argocd --version 5.51.3 --namespace argocd --create-namespace argo/argo-cd -f values-argocd.yaml --set 'server.ingress.hosts[0]=argocd.dreamit.local' --set 'server.ingress.tls[0].hosts[0]=argocd.dreamit.local'

deploy-external-secrets-operator:
	helm repo add external-secrets https://charts.external-secrets.io
	helm upgrade --install external-secrets external-secrets/external-secrets \
		-n external-secrets \
		--create-namespace
