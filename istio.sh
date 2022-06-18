# https://istio.io/latest/docs/setup/install/helm/
# https://istio.io/latest/docs/tasks/traffic-management/ingress/ingress-control/

helm repo add istio https://istio-release.storage.googleapis.com/charts
helm repo update

kubectl create namespace istio-system

helm install istio-base istio/base -n istio-system

helm install istiod istio/istiod -n istio-system --wait

kubectl create namespace istio-ingress
kubectl label namespace istio-ingress istio-injection=enabled
helm install istio-ingress istio/gateway -n istio-ingress --wait

kubectl apply -f samples/httpbin/httpbin.yaml
# httpbin-gateway.yaml has chnages and its comitted in this repo
kubectl apply -f samples/httpbin/httpbin-gateway.yaml

curl -v -k --header 'Host: httpbin.example.com'   "http://20.241.217.148:80/get"

#SSL

openssl req -x509 -sha256 -nodes -days 365 -newkey rsa:2048 -subj '/O=example Inc./CN=example.com' -keyout example.com.key -out example.com.crt

openssl req -out httpbin.example.com.csr -newkey rsa:2048 -nodes -keyout httpbin.example.com.key -subj "/CN=httpbin.example.com/O=httpbin organization"
openssl x509 -req -sha256 -days 365 -CA example.com.crt -CAkey example.com.key -set_serial 0 -in httpbin.example.com.csr -out httpbin.example.com.crt

kubectl create -n api-1 secret tls httpbin-credential --key=httpbin.example.com.key --cert=httpbin.example.com.crt



 
