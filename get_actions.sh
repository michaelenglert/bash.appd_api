source ./login.sh

function apiCall {
  $CURL_DEFAULT -b cookie.txt \
                -X GET \
                -H "X-CSRF-TOKEN: $XCSRFTOKEN" \
                -H "Cookie: JSESSIONID=$JSESSIONID; X-CSRF-TOKEN=$XCSRFTOKEN" \
                -H "Content-Type: application/json" \
                -H "Accept: application/json, text/plain, */*" \
                $CONTROLLER_PREFIX$CONTROLLER_HOST:$CONTROLLER_PORT/restui/event_reactor/getAllEventReactorsForApplication/$APP_ID
}

function readInput {
  echo -n "Specify App ID: "
  read APP_ID
}

readInput
apiCall
doneDone
