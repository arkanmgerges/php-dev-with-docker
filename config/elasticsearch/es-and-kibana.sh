#!/bin/bash

nohup /opt/kibana/bin/kibana &
exec "/docker-entrypoint.sh" "elasticsearch" "-Des.network.host=0.0.0.0"
