source ./login.sh

function apiCall {
  $CURL_DEFAULT -b cookie.txt \
                -X POST \
                -H "X-CSRF-TOKEN: $XCSRFTOKEN" \
                -H "Content-Type: application/json;charset=UTF-8" \
                -H "Accept: application/json, text/plain, */*" \
                -d "{ \
                      \"username\": \"$DB_USER\",\
                      \"hostname\": \"$DB_IP\",\
                      \"agentName\": \"$DB_AGENT\",\
                      \"type\": \"$DB_TYPE\",\
                      \"orapkiSslEnabled\": false,\
                      \"orasslTruststoreLoc\": null,\
                      \"orasslTruststoreType\": null,\
                      \"orasslTruststorePassword\": null,\
                      \"orasslClientAuthEnabled\": false,\
                      \"orasslKeystoreLoc\": null,\
                      \"orasslKeystoreType\": null,\
                      \"orasslKeystorePassword\": null,\
                      \"name\": \"$DB_COLLECTOR_NAME\",\
                      \"databaseName\": \"$DB_NAME\",\
                      \"port\": \"$DB_PORT\",\
                      \"password\": \"$DB_PASSWORD\",\
                      \"excludedSchemas\": [],\
                      \"enabled\": true\
                    }" \
                $CONTROLLER_PREFIX$CONTROLLER_HOST:$CONTROLLER_PORT/controller/restui/databases/collectors/createConfiguration
}

function readInput {
  echo -n "Specify DB User: "
  read DB_USER

  echo -n "Specify DB Host/IP: "
  read DB_IP

  echo -n "Specify DB Agent Name (Optional): "
  read DB_AGENT

  if [[ -z ${DB_AGENT} ]]; then
    echo -e "DB Agent Name not set. Using Default Database Agent"
    DB_AGENT="Default Database Agent"
  fi

  echo -n "Specify DB Type (DB2/Oracle/...): "
  read DB_TYPE

  echo -n "Specify the name of the Collector: "
  read DB_COLLECTOR_NAME

  echo -n "Specify the name of the DB: "
  read DB_NAME

  echo -n "Specify the port of the DB: "
  read DB_PORT

  echo -n "Specify the Password for the DB: "
  read -s DB_PASSWORD
}

readInput
apiCall
doneDone
