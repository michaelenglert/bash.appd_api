source ./login.sh

function apiCall {
  $CURL_DEFAULT -b cookie.txt \
                -X GET \
                -H "X-CSRF-TOKEN: $XCSRFTOKEN" \
                -H "Cookie: JSESSIONID=$JSESSIONID; X-CSRF-TOKEN=$XCSRFTOKEN" \
                -H "Content-Type: application/json;charset=UTF-8" \
                -H "Accept: application/json, text/plain, */*"\
                $CONTROLLER_PREFIX$CONTROLLER_HOST:$CONTROLLER_PORT/controller/CustomDashboardImportExportServlet?dashboardId=$DASHBOARD_ID
}

function readInput {
  echo -n "Specify Dashboard ID: "
  read DASHBOARD_ID
}

readInput
apiCall
doneDone
