kubectl apply -f recommended.yaml
# 看看状态
# kubectl get svc,pod  -n kubernetes-dashboard  -o wide
#NAME                                TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)         AGE   SELECTOR
#service/dashboard-metrics-scraper   ClusterIP   10.102.198.235   <none>        8000/TCP        48s   k8s-app=dashboard-metrics-scraper
#service/kubernetes-dashboard        NodePort    10.108.85.90     <none>        443:30010/TCP   49s   k8s-app=kubernetes-dashboard

#NAME                                             READY   STATUS    RESTARTS   AGE   IP           NODE            NOMINATED NODE   READINESS GATES
#pod/dashboard-metrics-scraper-795895d745-w8696   1/1     Running   0          48s   10.244.1.5   vm-0-9-centos   <none>           <none>
#pod/kubernetes-dashboard-78f95ff46f-7vntp        1/1     Running   0          48s   10.244.1.4   vm-0-9-centos   <none>           <none>




echo "其实这里是需要通过名字'vm-0-9-centos'然后手动确认ip是啥。。。。看他在那个服务器上运行的"
echo "暂时我还没时间找更方便的操作，等之后把。。。"
echo "端口就是30010, 不过你的浏览器可能要加https才让你访问：https://43.156.34.234:30010/"
#ip=`kubectl get svc/kubernetes-dashboard -n kubernetes-dashboard -o jsonpath='{.spec.clusterIP}'`
#echo "dashboard url:"
#echo "$ip:30010"


echo "建立超级用户"
kubectl create -f k8s-admin.yaml

echo "用这个token登录dashboard:"
kubectl -n kubernetes-dashboard create token dashboard-admin

