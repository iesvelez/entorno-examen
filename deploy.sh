#! /bin/bash

########################################################################
#
# Configuración
#
########

source deploy.conf

NET_ID=`neutron net-list | awk "/$NET_NAME/ {print $2}"`


########################################################################
#
# Creación de instancias y asignación de IPs flotantes
#
########

truncate -s 0 $OUTPUT

time for i in `seq $NUM`
do
	INSTANCE_NAME=`printf "${NAME}%02d" $i`
	INSTANCE_ID=`nova boot --flavor $FLAVOR \
		--security-groups $SECURITY_GROUPS \
		--key-name $KEY_NAME \
		--nic net-id=$NET_ID \
		--image $IMAGE_ID \
		$INSTANCE_NAME | awk '/id/ {print $4}'`

	sleep 2

	FLOATING_IP=`nova floating-ip-create ext-net | awk 'NR==4 {print $4}'`
	nova floating-ip-associate $INSTANCE_NAME $FLOATING_IP


	echo -e "$FLOATING_IP\t$INSTANCE_NAME" | tee -a $INSTANCE_FILE
done
