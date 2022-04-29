#!/bin/bash

# Usage: install-ambari.sh agent|server

if [ "$1" == "" ];then
	echo "Please provide node type, for Ambari server, usage) install-ambari.sh agent|server"
	exit 2
fi

NODE_TYPE=$1  # server or agent

# Download Ambari agent
AMBARI_AGENT_DOWNLOAD_LOG=agent-download-progress.log
AMBARI_AGENT_OUTPUT_PATH=/tmp/ambari-agent.rpm
if [ $NODE_TYPE = "agent" ]; then
  echo "Downloading ambari agent..."
  wget -b -o $AMBARI_AGENT_DOWNLOAD_LOG --no-check-certificate https://www.makeopensourcegreatagain.com/rpms/ambari-$AMBARI_VERSION/ambari/ambari-agent-$AMBARI_VERSION-118.x86_64.rpm -O $AMBARI_AGENT_OUTPUT_PATH
	FILE_TO_INSTALL=$AMBARI_AGENT_OUTPUT_PATH
fi

# Download Ambari server if it is server
AMBARI_SERVER_DOWNLOAD_LOG=server-download-progress.log
AMBARI_SERVER_OUTPUT_PATH=/tmp/ambari-server.rpm
if [ $NODE_TYPE = "server" ]; then
	echo "Downloading ambari server..."
  wget -b -o $AMBARI_SERVER_DOWNLOAD_LOG --no-check-certificate https://www.makeopensourcegreatagain.com/rpms/ambari-$AMBARI_VERSION/ambari/ambari-server-$AMBARI_VERSION-118.x86_64.rpm -O $AMBARI_SERVER_OUTPUT_PATH
	FILE_TO_INSTALL=$AMBARI_SERVER_OUTPUT_PATH
fi

yum install -y $FILE_TO_INSTALL
