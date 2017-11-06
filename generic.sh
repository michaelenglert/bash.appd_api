source ./login.sh

function apiCall {
  $CURL_DEFAULT -b cookie.txt \
                -X $METHOD\
                -H "X-CSRF-TOKEN: $XCSRFTOKEN" \
                -H "Cookie: JSESSIONID=$JSESSIONID; X-CSRF-TOKEN=$XCSRFTOKEN" \
                -H "Content-Type: application/json;charset=UTF-8" \
                -H "Accept: application/json, text/plain, */*"\
                -d "$JSON_PAYLOAD" \
                $CONTROLLER_PREFIX$CONTROLLER_HOST:$CONTROLLER_PORT$ENDPOINT$QUERY_PARAMETER
}

function readInput {
  echo -n "Specify Method (GET/POST/PUT): "
  read METHOD
  echo -n "Specify API Endpoint (e.g. /controller/rest/applications): "
  read ENDPOINT
  if [[ "$METHOD" == "GET" ]]; then
    echo -n "Specify Query Parameters (Optional): "
    read QUERY_PARAMETER
  elif [[ "$METHOD" == "POST" ]]; then
    echo -n "Specify JSON Payload: "
    read JSON_PAYLOAD
  fi
}

readInput
apiCall
doneDone
