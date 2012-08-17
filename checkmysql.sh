#!/bin/bash

# MySQL Server root/admin username
MUSER="root"

# MySQL Server admin/root password
MPASS="SET-ROOT-PASSWORD"

# MySQL Server hostname
MHOST="localhost"

#Shell script to start MySQL server i.e. path to MySQL daemon start/stop script.
MSTART="/etc/init.d/mysql start"

# Email ID to send notification
EMAILID="you@your-email.com"

# path to mail program
MAILCMD="$(which mail)"

# path mysqladmin
MADMIN="$(which mysqladmin)"

#### DO NOT CHANGE anything BELOW ####
MAILMESSAGE="/tmp/mysql.fail.$$"

# see if MySQL server is alive or not
# 2&1 could be better but i would like to keep it simple and easy to
# understand stuff
$MADMIN -h $MHOST -u $MUSER -p${MPASS} ping 2>/dev/null 1>/dev/null
if [ $? -ne 0 ]; then
echo "" >$MAILMESSAGE
echo "Error: MySQL Server is not running/responding ping request">>$MAILMESSAGE
echo "Hostname: $(hostname)" >>$MAILMESSAGE
echo "Date & Time: $(date)" >>$MAILMESSAGE
# try to start mysql
$MSTART>/dev/null
# see if it is started or not
o=$(ps cax | grep -c ' mysqld$')
if [ $o -eq 1 ]; then
sMess="MySQL Server MySQL server successfully restarted"
else
sMess="MySQL server FAILED to restart"
fi
# Email status too
echo "Current Status: $sMess" >>$MAILMESSAGE
echo "" >>$MAILMESSAGE
echo "*** This email generated by $(basename $0) shell script ***" >>$MAILMESSAGE
echo "*** Please don't reply this email, this is just notification email ***" >>$MAILMESSAGE
# send email
$MAILCMD -s "MySQL server" $EMAILID < $MAILMESSAGE
else # MySQL is running and do nothing
:
fi
# remove file
rm -f $MAILMESSAGE