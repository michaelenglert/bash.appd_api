#!/bin/bash

CURL_DEFAULT='curl -L '

function checkCurl {
  which curl &> /dev/null
  if [[ $? != 0 ]]; then
    echo "curl is not installed - exiting"
    exit 1
  fi
}

function getOptions {
  while getopts ":u:p:c:P:s:t" opt;
  do
   case "${opt}" in
     u) CONTROLLER_USER=${OPTARG}
        echo "CONTROLLER_USER=${CONTROLLER_USER}"
        ;;
     p) CONTROLLER_PASSWORD=${OPTARG};;
     c) CONTROLLER_HOST=${OPTARG}
        echo "CONTROLLER_HOST=${CONTROLLER_HOST}"
        ;;
     P) CONTROLLER_PORT=${OPTARG}
        echo "CONTROLLER_PORT=${CONTROLLER_PORT}"
        ;;
     s) CONTROLLER_SSL=${OPTARG}
        echo "CONTROLLER_SSL=${CONTROLLER_SSL}"
        ;;
     t) CONTROLLER_TENANT=${OPTARG}
        echo "CONTROLLER_TENANT=${CONTROLLER_TENANT}"
        ;;
     \?)  echo "ERROR: Invalid Argument -${OPTARG}"
          usage
          ;;
   esac
  done
}

function checkOptions {
  if [[ -z ${CONTROLLER_USER} ]]; then
    echo "-u variable not set"
    usage
  fi
  if [[ -z ${CONTROLLER_PASSWORD} ]]; then
    echo "-p variable not set"
    askPassword
  fi
  if [[ -z ${CONTROLLER_HOST} ]]; then
    echo "-c variable not set"
    usage
  fi
  if [[ -z ${CONTROLLER_SSL} ]]; then
    echo -e "-s variable not set\nUsing false for ssl"
    CONTROLLER_SSL="false"
  fi
  if [[ -z ${CONTROLLER_PORT} ]]; then
    if [[ "$CONTROLLER_SSL" == "false" ]]; then
      echo -e "-P variable not set\nUsing 8090 as port"
      CONTROLLER_PORT="8090"
    else
      echo -e "-P variable not set\nUsing 8181 as port"
      CONTROLLER_PORT="8181"
    fi
  fi
  if [[ -z ${CONTROLLER_TENANT} ]]; then
    echo -e "-t variable not set\nUsing customer1 as tenant"
    CONTROLLER_TENANT="customer1"
  fi
}

function usage {
  echo -e "api.sh\t-u <CONTROLLER_USER>\n\t(-p <CONTROLLER_PASSWORD>) will be prompted if not provided\n\t-h <CONTROLLER_HOST\n\t(-P <CONTROLLER_PORT>) Optional\n\t(-s <CONTROLLER_SSL>) Optional Default: false\n\t(-t <CONTROLLER_TENANT>) Optional Default: customer1"
  exit 1
}

function askPassword {
  echo -e "Controller Password not set please provide it:"
  read -s CONTROLLER_PASSWORD
}

function login {
  if [[ "$CONTROLLER_SSL" == false ]]; then
    CONTROLLER_PREFIX="http://"
  else
    CONTROLLER_PREFIX="https://"
  fi
  LOGIN_RESPONSE=$($CURL_DEFAULT -sI -c cookie.txt \
  --user $CONTROLLER_USER@$CONTROLLER_TENANT:$CONTROLLER_PASSWORD \
  $CONTROLLER_PREFIX$CONTROLLER_HOST:$CONTROLLER_PORT/controller/auth?action=login)
  if [[ "${LOGIN_RESPONSE/200 OK}" != "$LOGIN_RESPONSE" ]]; then
    echo "Login Successful"
  fi
  XCSRFTOKEN=$(tail -1 cookie.txt | awk 'NF>1{print $NF}')
  echo "$XCSRFTOKEN"
}

checkCurl
getOptions $@
checkOptions
login

rm -rf cookie.txt

exit 0
