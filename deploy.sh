docker build -t faizan2590/multi-client:latest -t faizan2590/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t faizan2590/multi-server:latest -t faizan2590/multi-server:$SHA -f -/server/Dockerfile ./server
docker build -t faizan2590/multi-worker:latest -t faizan2590/multi-worker:$SHA -f -/worker/Dockerfile ./worker

docker push faizan2590/multi-client:latest
docker push faizan2590/multi-server:latest
docker push faizan2590/multi-worker:latest

docker push faizan2590/multi-client:$SHA
docker push faizan2590/multi-server:$SHA
docker push faizan2590/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=faizan2590/multi-server:$SHA
kubectl set image deployments/client-deployment client=faizan2590/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=faizan2590/multi-worker:$SHA