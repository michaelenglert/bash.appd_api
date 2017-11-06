source ./login.sh

function apiCall {
  $CURL_DEFAULT -b cookie.txt \
                -X POST\
                -H "X-CSRF-TOKEN: $XCSRFTOKEN" \
                -H "Cookie: JSESSIONID=$JSESSIONID; X-CSRF-TOKEN=$XCSRFTOKEN" \
                -H "Content-Type: application/json;charset=UTF-8" \
                -H "Accept: application/json, text/plain, */*"\
                -d "{\"name\":\"$TIMERANGE_NAME\",\"timeRange\":{\"type\":\"BETWEEN_TIMES\",\"durationInMinutes\":0,\"startTime\":$START_TIME,\"endTime\":$END_TIME}}" \
                $CONTROLLER_PREFIX$CONTROLLER_HOST:$CONTROLLER_PORT/controller/restui/user/createCustomRange
}

function readInput {
  echo -n "Specify Timerange Name: "
  read TIMERANGE_NAME
  echo -n "Specify Start Time in Unix Time (https://currentmillis.com/): "
  read START_TIME
  echo -n "Specify End Time in Unix Time (https://currentmillis.com/): "
  read END_TIME
}

readInput
apiCall
doneDone
