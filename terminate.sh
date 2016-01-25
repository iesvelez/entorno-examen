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


read -p '¿Estás seguro de querer terminar todas las instancias? (s/N): ' CONFIRM
[ "$CONFIRM" != "s" -a "$CONFIRM" != "S" ] && exit


time cat $INSTANCE_FILE | grep -vE ^$ | while read LINE
do
	FLOATING_IP=`echo $LINE | awk '{print $1}'`
	INSTANCE_NAME=`echo $LINE | awk '{print $2}'`

	echo -e "\n- Terminando instancia $INSTANCE_NAME y liberando IP $FLOATING_IP"

	nova delete $INSTANCE_NAME
	nova floating-ip-delete $FLOATING_IP
done

