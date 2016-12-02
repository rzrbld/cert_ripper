#!/bin/bash
for i in "$@"
do
case $i in
    -k=*|--path-to-keystore=*)
    KEYPATH="${i#*=}"
    ;;
    -p=*|--keysotre-password=*)
    KEYPASS="${i#*=}"
    ;;
    -h=*|--host=*)
    HOST="${i#*=}"
    ;;
    -n=*|--name=*)
    ALIAS="${i#*=}"
    ;;
    -help|--usage)
    USAGE="1"
    ;;
    --default)
    DEFAULT=YES
    ;;
    *)
            # unknown option
    ;;
esac
done

timestamp() {
  date +%s
}

if [[ $USAGE = "1" ]] ; then
echo "
▄█▄    ▄███▄   █▄▄▄▄    ▄▄▄▄▀     █▄▄▄▄ ▄█ █ ▄▄  █ ▄▄  ▄███▄   █▄▄▄▄
█▀ ▀▄  █▀   ▀  █  ▄▀ ▀▀▀ █        █  ▄▀ ██ █   █ █   █ █▀   ▀  █  ▄▀
█   ▀  ██▄▄    █▀▀▌      █        █▀▀▌  ██ █▀▀▀  █▀▀▀  ██▄▄    █▀▀▌
█▄  ▄▀ █▄   ▄▀ █  █     █         █  █  ▐█ █     █     █▄   ▄▀ █  █
▀███▀  ▀███▀     █     ▀            █    ▐  █     █    ▀███▀     █
                ▀                  ▀         ▀     ▀            ▀
"
   echo "example: ./certripper.sh -k=/home/esb/wso2esb-4.8.1/repository/resources/security/client-truststore.jks -p=wso2carbon -h=example.com:443 -n=example.com"
   echo "------";
   echo "explain:"
   echo "-k    or --path-to-keystore  = path to keystore"
   echo "-p    or --keysotre-password = keystore password"
   echo "-h    or --host              = target host"
   echo "-n    or --name              = alias prefix"
   echo "-help or --usage             = this help"
   exit 1
fi
#init enviroment
mkdir -p collection
mkdir -p splitted
#remove preview splitters and collection
rm -rf splitted/*
rm -rf collection/*
#main
echo | openssl s_client -connect ${HOST} -showcerts 2>&1 | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' > collection/collection.pem &&
csplit -f splitted/${ALIAS}- collection/collection.pem '/-----BEGIN CERTIFICATE-----/' '{*}' &&
rm splitted/${ALIAS}-00

FILES=splitted/*
for f in $FILES
do
  echo "Adding $f to keystore..."
  keytool -importcert -file $f -keystore ${KEYPATH} -alias "$f-$(timestamp)" -noprompt -storepass ${KEYPASS}
done
