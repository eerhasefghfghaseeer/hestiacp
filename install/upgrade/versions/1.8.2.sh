#!/bin/bash

# Hestia Control Panel upgrade script for target version 1.8.2

#######################################################################################
#######                      Place additional commands below.                   #######
#######################################################################################
####### upgrade_config_set_value only accepts true or false.                    #######
#######                                                                         #######
####### Pass through information to the end user in case of a issue or problem  #######
#######                                                                         #######
####### Use add_upgrade_message "My message here" to include a message          #######
####### in the upgrade notification email. Example:                             #######
#######                                                                         #######
####### add_upgrade_message "My message here"                                   #######
#######                                                                         #######
####### You can use \n within the string to create new lines.                   #######
#######################################################################################

upgrade_config_set_value 'UPGRADE_UPDATE_WEB_TEMPLATES' 'true'
upgrade_config_set_value 'UPGRADE_UPDATE_DNS_TEMPLATES' 'false'
upgrade_config_set_value 'UPGRADE_UPDATE_MAIL_TEMPLATES' 'true'
upgrade_config_set_value 'UPGRADE_REBUILD_USERS' 'false'
upgrade_config_set_value 'UPGRADE_UPDATE_FILEMANAGER_CONFIG' 'false'

# Migrate the system SFTP jail
echo "[ ! ] Migrating SFTP Chroot Jail..."
if grep -q '^# Hestia SFTP Chroot' /etc/ssh/sshd_config; then
	$BIN/v-delete-sys-sftp-jail
	$BIN/v-add-sys-sftp-jail
else
	rm -f /etc/cron.d/hestia-sftp
fi
