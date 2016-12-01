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

if [[ $USAGE = "1" ]] ; then
echo "
▄█▄    ▄███▄   █▄▄▄▄    ▄▄▄▄▀     █▄▄▄▄ ▄█ █ ▄▄  █ ▄▄  ▄███▄   █▄▄▄▄
█▀ ▀▄  █▀   ▀  █  ▄▀ ▀▀▀ █        █  ▄▀ ██ █   █ █   █ █▀   ▀  █  ▄▀
█   ▀  ██▄▄    █▀▀▌      █        █▀▀▌  ██ █▀▀▀  █▀▀▀  ██▄▄    █▀▀▌
█▄  ▄▀ █▄   ▄▀ █  █     █         █  █  ▐█ █     █     █▄   ▄▀ █  █
▀███▀  ▀███▀     █     ▀            █    ▐  █     █    ▀███▀     █
                ▀                  ▀         ▀     ▀            ▀
"
   echo "example: ./certripper.sh -k=/home/esb/wso2esb-4.8.1/repository/resources/security -p=wso2carbon -h=example.com:443"
   echo "------";
   echo "explain:"
   echo "-k    or --path-to-keystore  = path to keystore"
   echo "-p    or --keysotre-password = keystore password"
   echo "-h    or --host              = target host"
   echo "-help or --usage             = this help"
   exit 1
fi

mkdir -p collection
mkdir -p splitted
echo | openssl s_client -connect ${HOST} -showcerts 2>&1 | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' > collection/collection.pem &&
csplit -f splitted/individual- collection/collection.pem '/-----BEGIN CERTIFICATE-----/' '{*}' &&
rm splitted/individual-00

FILES=splitted/*
for f in $FILES
do
  echo "Adding $f to keystore..."
  keytool -importcert -file $f -keystore ${KEYPATH}/client-truststore.jks -alias "$f-$(date)" -noprompt -storepass ${KEYPASS}
done
