
while [ $# -gt 0 ]; do
  case "$1" in
  --proxy)
    export HTTP_PROXY="$2"
    export HTTPS_PROXY="$2"
    NO_PROXY="127.0.0.0/8,10.0.0.0/8,100.64.0.0/10,172.16.0.0/12,192.168.0.0/16"
    NO_PROXY="${NO_PROXY},127.0.0.1,localhost"
    export NO_PROXY="${NO_PROXY}"
    ;;

  --*)
    echo "Illegal option $1"
    ;;
  esac
  shift $(($# > 0 ? 1 : 0))
done

# nginx ingress
# https://kubernetes.github.io/ingress-nginx/deploy/#bare-metal-clusters
# https://github.com/kubernetes/ingress-nginx/tags
VERSION="1.9.5"
curl  -L -o nginx-ingress-v${VERSION}-deploy.yaml  https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v${VERSION}/deploy/static/provider/baremetal/deploy.yaml

kubectl create -f nginx-ingress-v${VERSION}-deploy.yaml
