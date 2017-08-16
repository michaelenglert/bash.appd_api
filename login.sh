source ./base.sh

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
}
