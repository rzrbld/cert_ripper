# certripper
get cert chain from target host, parse it and put each cert to java keystore
example: ./certripper.sh -k=/home/esb/wso2esb-4.8.1/repository/resources/security/client-truststore.jks -p=wso2carbon -h=example.com:443 -n=example.com

commands:
-k    or --path-to-keystore  = path to keystore
-p    or --keysotre-password = keystore password
-h    or --host              = target host
-n    or --name              = alias prefix
-help or --usage             = this help
