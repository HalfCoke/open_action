#!/bin/bash

# check params
echo "1: check parameter..."
if [ -n "$EMAIL" ]; then
  echo "EMAIL:$EMAIL"
else
  echo 'invalid EMAIL parameter'
  exit 0
fi

if [ -n "$DOMAINS" ]; then
  echo "DOMAINS:$DOMAINS"
else
  echo 'invalid DOMAINS parameter'
  exit 0
fi

#API
#DNSPOD;id,key
IFS=';'; read -ra api_params <<< "$API"; unset IFS
if [ ${#api_params[@]} = 2 ]; then
  if [[ ${api_params[0]} == DNSPOD ]]; then
      IFS=','; read -ra dp_api_params <<< "${api_params[1]}"; unset IFS
      if [ ${#dp_api_params[@]} = 2 ]; then
        export DP_Id=${dp_api_params[0]}
        export DP_Key=${dp_api_params[1]}
        DNSPOD_ENABLED='true'
        echo "enable DNSPOD"
        echo "DP_Id:*****"
        echo "DP_Key:*****"
      else
        	echo "invalid DNSPOD parameter"
      fi
  else
      echo "unsupported API parameter"
  fi
else
	echo "invalid API parameter"
	exit 0
fi

echo "2: install acme.sh"
cd /
unzip /acme.zip

cd /acme.sh-master/

./acme.sh --install  \
--cert-home  /ssl \
--accountemail "$EMAIL"

CMD="$HOME/.acme.sh/acme.sh --issue --dns"

# select api
if [ -n "$DNSPOD_ENABLED" ]; then
  CMD=$CMD" dns_dp"
fi

# build cmd
IFS=','; read -ra domains <<< "${DOMAINS}"; unset IFS
for domain in "${domains[@]}"
do
  CMD=$CMD" -d ${domain}"
done

echo "3: CMD: $CMD"
echo "3: Get certificate"
eval "$CMD"

# daemon
trap "echo stop && killall crond && exit 0" SIGTERM SIGINT
crond && sleep infinity &
wait