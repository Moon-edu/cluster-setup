#!/bin/bash

if [ "$1" == "" ];then
  echo "Please provide password for ambari user"
  exit 2
fi

#if [ "$2" == "" ];then
#	echo "Please provide node type, for Ambari server, type server. otherwise type agent"
#	exit 2
#fi

if ! [ -f "$2" ]; then
  echo "Warning: User list not provided"
fi

AMBARI_PASSWORD=$1
USER_LIST_FILE=$2
AMBARI_USER_NAME=ambari
DEFAULT_STUDENT_GROUP=student
AMBARI_VERSION=2.7.4.0

yum update -y

if ! [ -x "$(command -v wget)" ]; then
  echo "wget not exists, installing wget..."
	yum install -y wget
fi

# Install required binaries
yum install -y python3  java-1.8.0-openjdk docker

# Set Java Home for All user
java -XshowSettings:properties -version 2>&1> /dev/null | grep "java.home" | awk -F"=" '{gsub(/[ \t]/, "", $2); print "export JAVA_HOME="$2}' > /etc/profile.d/java_home.sh

# Add ambari user. Ambari is actually root user

adduser $AMBARI_USER_NAME
echo "$AMBARI_PASSWORD" | passwd $AMBARI_USER_NAME --stdin
echo "$AMBARI_USER_NAME  ALL=(ALL) NOPASSWD:ALL" | tee /etc/sudoers.d/$AMBARI_USER_NAME

# Add users for students
groupadd $DEFAULT_STUDENT_GROUP

if [ "$USER_LIST_FILE" != "" ]; then
	while read user_info; do
		U=($user_info)
		U_NAME "${U[0]}"
		U_PW "${U[1]}"
  
  	adduser -m -g $DEFAULT_STUDENT_GROUP $U_NAME
  	echo $U_PW | passwd $U_NAME --stdin 	
	done < $USER_LIST_FILE
else
	echo "No user added"
fi

function install_if_download_is_done() {
	NOT_DONE=1
	DONE=0
	SLEEP_DURATION=5  #Seconds

	LOG_FILE=$1
	FILE_TO_INSTALL=$2  #Absolute path

	flag=$NOT_DONE
	while [ $flag -eq 1 ];do
    last_log=$(tail -5 $LOG_FILE | grep "100%")
    if [ "$last_log" = "" ]; then
      echo "$FILE_TO_INSTALL is not done yet. Sleep $SLEEP_DURATION secs..."
			sleep $SLEEP_DURATION
		else
			flag=$DONE
			echo "$FILE_TO_INSTALL has been downloaded. Install in progress..."
			yum install -y $FILE_TO_INSTALL
		fi
	done
}

# Install Ambari agent
#install_if_download_is_done $AMBARI_AGENT_DOWNLOAD_LOG $AMBARI_AGENT_OUTPUT_PATH
#install_if_download_is_done $AMBARI_SERVER_DOWNLOAD_LOG $AMBARI_SERVER_OUTPUT_PATH
