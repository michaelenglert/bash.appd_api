source ./login.sh

function testingMethod {
  $CURL_DEFAULT -b cookie.txt \
                -H "X-CSRF-TOKEN: $XCSRFTOKEN" \
                $CONTROLLER_PREFIX$CONTROLLER_HOST:$CONTROLLER_PORT/controller/restui/flowMapUiService/flowmaps/APPLICATION/175
}

testingMethod
doneDone
