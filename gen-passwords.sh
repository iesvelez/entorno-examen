#!/bin/bash

########################################################################
#
# Configuración
#
########

source deploy.conf


########################################################################
#
# Generar constraseñas de root
#
########

PASSLIST=`apg -n 100 -m 6 -x 6 -M NL`

truncate -s 0 $OUTPUT

cat $INSTANCE_FILE | grep -v '^$' | {
	IFS=,
	while read IP HOST
	do
		PASS=`echo $PASSLIST | head -n 1`
		PASSLIST=`echo $PASSLIST | tail -n +2`

		echo -e "$IP\t$HOST\t$PASS" | tee -a $PASSWD_FILE

		ssh -fT ubuntu@$IP "echo root:$PASS | sudo chpasswd"
	done
}
