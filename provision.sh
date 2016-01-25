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

echo "[default]" > $INVENTORY_FILE

cat $INSTANCE_FILE | grep -vE ^$ | while read LINE
do
	FLOATING_IP=`echo $LINE | awk '{print $1}'`
	INSTANCE_NAME=`echo $LINE | awk '{print $2}'`

	echo -e "$INSTANCE_NAME ansible_ssh_host=$FLOATING_IP ansible_ssh_port=22" | tee -a $INVENTORY_FILE
done


########################################################################
#
# Ejecutar playbook
#
########

ansible-playbook site.yml

