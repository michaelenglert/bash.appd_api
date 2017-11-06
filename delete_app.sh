source ./login.sh

function apiCall {
  $CURL_DEFAULT -b cookie.txt \
                -X POST \
                -H "X-CSRF-TOKEN: $XCSRFTOKEN" \
                -H "Cookie: JSESSIONID=$JSESSIONID; X-CSRF-TOKEN=$XCSRFTOKEN" \
                -H "Content-Type: application/json" \
                -H "Accept: application/json, text/plain, */*" \
                -d "$APP_ID" \
                $CONTROLLER_PREFIX$CONTROLLER_HOST:$CONTROLLER_PORT/restui/allApplications/deleteApplication
}

function readInput {
  echo -n "Specify App ID: "
  read APP_ID
}

readInput
apiCall
doneDone
