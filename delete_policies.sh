source ./login.sh

function apiCall {
  $CURL_DEFAULT -b cookie.txt \
                -X POST \
                -H "X-CSRF-TOKEN: $XCSRFTOKEN" \
                -H "Cookie: JSESSIONID=$JSESSIONID; X-CSRF-TOKEN=$XCSRFTOKEN" \
                -H "Content-Type: application/json" \
                -H "Accept: application/json, text/plain, */*" \
                -d "[$POLICY_IDS]" \
                $CONTROLLER_PREFIX$CONTROLLER_HOST:$CONTROLLER_PORT/restui/policy/delete
}

function readInput {
  echo -n "Specify Policy IDs (Comma separated for multiple): "
  read POLICY_IDS
}

readInput
apiCall
doneDone
