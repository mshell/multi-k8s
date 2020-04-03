docker build -t martinshell/multi-client:latest -t martinshell/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t martinshell/multi-server:latest -t martinshell/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t martinshell/multi-worker:latest -t martinshell/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push martinshell/multi-client:latest
docker push martinshell/multi-server:latest
docker push martinshell/multi-worker:latest
docker push martinshell/multi-client:$SHA
docker push martinshell/multi-server:$SHA
docker push martinshell/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=martinshell/multi-server:$SHA
kubectl set image deployments/client-deployment client=martinshell/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=martinshell/multi-worker:$SHA