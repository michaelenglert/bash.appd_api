source ./login.sh

function apiCall {
  $CURL_DEFAULT -b cookie.txt \
                -X POST \
                -H "X-CSRF-TOKEN: $XCSRFTOKEN" \
                -H "Cookie: JSESSIONID=$JSESSIONID; X-CSRF-TOKEN=$XCSRFTOKEN" \
                -H "Content-Type: application/json" \
                -H "Accept: application/json, text/plain, */*" \
                -d "[$ACTION_IDS]" \
                $CONTROLLER_PREFIX$CONTROLLER_HOST:$CONTROLLER_PORT/restui/policy/deleteActions
}

function readInput {
  echo -n "Specify Action IDs (Comma separated for multiple): "
  read ACTION_IDS
}

readInput
apiCall
doneDone
