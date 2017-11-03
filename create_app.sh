source ./login.sh

function apiCall {
  $CURL_DEFAULT -b cookie.txt \
                -X POST \
                -H "X-CSRF-TOKEN: $XCSRFTOKEN" \
                -H "Content-Type: application/json;charset=UTF-8" \
                -H "Accept: application/json, text/plain, */*" \
                -d "{ \
                      \"name\": \"$APP_NAME\",\
                      \"description\": \"$APP_DESC\"\
                    }" \
                $CONTROLLER_PREFIX$CONTROLLER_HOST:$CONTROLLER_PORT/restui/allApplications/createApplication?applicationType=APM
}

function readInput {
  echo -n "Specify App Name: "
  read APP_NAME

  echo -n "Specify App Description (Optional): "
  read APP_DESC
}

readInput
apiCall
doneDone
