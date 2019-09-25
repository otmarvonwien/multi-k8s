docker build -t otmarvonwien/multi-client:latest -t otmarvonwien/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t otmarvonwien/multi-server:latest -t otmarvonwien/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t otmarvonwien/multi-worker:latest -t otmarvonwien/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push otmarvonwien/multi-client:latest
docker push otmarvonwien/multi-server:latest
docker push otmarvonwien/multi-worker:latest

docker push otmarvonwien/multi-client:$SHA
docker push otmarvonwien/multi-server:$SHA
docker push otmarvonwien/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=otmarvonwien/multi-server:$SHA
kubectl set image deployments/client-deployment client=otmarvonwien/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=otmarvonwien/multi-worker:$SHA
