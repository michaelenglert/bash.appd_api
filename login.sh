source ./base.sh

function login {
  if [[ "$CONTROLLER_SSL" == false ]]; then
    CONTROLLER_PREFIX="http://"
  else
    CONTROLLER_PREFIX="https://"
  fi
  LOGIN_RESPONSE=$($CURL_DEFAULT -D headers.txt -sI \
    --user $CONTROLLER_USER@$CONTROLLER_TENANT:$CONTROLLER_PASSWORD \
    $CONTROLLER_PREFIX$CONTROLLER_HOST:$CONTROLLER_PORT/controller/auth?action=login)
  if [[ "${LOGIN_RESPONSE/200 OK}" != "$LOGIN_RESPONSE" ]]; then
    echo "Login Successful"
  else
    echo "Login Error"
    exit 1
  fi
  XCSRFTOKEN=$(cat headers.txt | grep -i x-csrf | awk -F'=' '{print $2}')
  JSESSIONID=$(cat headers.txt | grep -i jsession | awk -F'[=;]' '{print $2}')
}

login
