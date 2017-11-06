source ./login.sh

function apiCall {
  $CURL_DEFAULT -b cookie.txt \
                -X POST \
                -H "X-CSRF-TOKEN: $XCSRFTOKEN" \
                -H "Cookie: JSESSIONID=$JSESSIONID; X-CSRF-TOKEN=$XCSRFTOKEN" \
                -H "Content-Type: application/json;charset=UTF-8" \
                -H "Accept: application/json, text/plain, */*" \
                -d "[$DASHBOARD_IDS]" \
                $CONTROLLER_PREFIX$CONTROLLER_HOST:$CONTROLLER_PORT/controller/restui/dashboards/deleteDashboards
}

function readInput {
  echo -n "Specify Dashboard IDs (e.g. 33,34): "
  read DASHBOARD_IDS
}

readInput
apiCall
doneDone
