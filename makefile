
#minikube commands
start-default:
	minikube start

start-docker:
	minikube start --driver=docker

stop:
	minikube stop

delete: 
	minikube delete 

status:
	minikube status

addons: 
	minikube addons enable volumesnapshots
	minikube addons enable csi-hostpath-driver


# start gemini
gemini: 
	kubectl create ns gemini
	helm install gemini fairwinds-stable/gemini --namespace gemini

#handle mongo db setup
mongodb-sec-conf:
	kubectl apply -f config/mongo-config.yml
	kubectl apply -f mongo-secret.yml


pvc-deploy: 
	kubectl apply -f mongo-pvc.yml
	kubectl apply -f mongo-deployment.yml

# wait:
# 	timeout 5

seed-data: 
	kubectl apply -f seed.yml

deployment-express:
	kubectl apply -f mongo-express-deployment.yml


mongo-backup:
	kubectl apply -f mongo-snapshotgroup.yml


frontend-config:
	kubectl apply -f config/microservice-config.yml


frontend-pre-setting:
	kubectl apply -f frontpage/order-processing-deployment.yml
	kubectl apply -f frontpage/product-catalog-deployment.yml
	kubectl apply -f frontpage/user-management-deployment.yml

frontend-home-page:
	kubectl apply -f frontpage/home-page-development.yml

scale-down-all-d: #default namespace
	kubectl scale deploy -n default --replicas=0 --all 

scale-up-all-d: #default namespace
	kubectl scale deploy -n default --replicas=1 --all 