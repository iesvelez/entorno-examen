#! /bin/bash

########################################################################
#
# Configuración
#
########

source deploy.conf


########################################################################
#
# Iterar la lista de instancias e IPs flotantes
#
########

case $1 in
	start|stop|suspend|resume|pause|unpause|lock|unlock)
		ACTION=$1
        ;;
	*)
		echo "$0 {start|stop|suspend|resume|pause|unpause|lock|unlock}"
		exit
        ;;
esac


time cat $INSTANCE_FILE | grep -vE ^$ | while read LINE
do
	FLOATING_IP=`echo $LINE | awk '{print $1}'`
	INSTANCE_NAME=`echo $LINE | awk '{print $2}'`

	echo -e "\n- Instancia $INSTANCE_NAME"

	nova $ACTION $INSTANCE_NAME
done



