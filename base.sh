#!/bin/bash

CURL_DEFAULT='curl -L --connect-timeout 10'

function checkCurl {
  which curl &> /dev/null
  if [[ $? != 0 ]]; then
    echo "curl is not installed - exiting"
    exit 1
  fi
}

function getOptions {
  while getopts ":u:p:c:P:s:t:" opt;
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
  echo -e "$0\t-u <CONTROLLER_USER>\n\t\
            (-p <CONTROLLER_PASSWORD>) will be prompted if not provided\n\t\
            -c <CONTROLLER_HOST>\n\t\
            (-P <CONTROLLER_PORT>) Optional - Default: 8090/8181(ssl)\n\t\
            (-s <CONTROLLER_SSL>) Optional - Default: false\n\t\
            (-t <CONTROLLER_TENANT>) Optional - Default: customer1"
  exit 1
}

function askPassword {
  echo -e "Controller Password not set please provide it:"
  read -s CONTROLLER_PASSWORD
}

function doneDone {
  rm -rf headers.txt
  exit 0
}

checkCurl
getOptions $@
checkOptions
