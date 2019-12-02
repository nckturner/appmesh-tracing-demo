#!/usr/bin/env bash

kubectl -n appmesh-system port-forward svc/appmesh-prometheus 9090 &
pids[${i}]=$!
kubectl -n appmesh-system port-forward svc/appmesh-jaeger 16686 &
pids[${i}]=$!
kubectl -n appmesh-system port-forward svc/appmesh-grafana 3000 &
pids[${i}]=$!
kubectl -n sock-shop port-forward deployment/front-end 8079 &

for pid in ${pids[*]}; do
    wait $pid
done
