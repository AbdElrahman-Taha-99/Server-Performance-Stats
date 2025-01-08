# Server-Performance-Stats
Shell script to analyze basic server performance stats.

$ chmod +x server-stats.sh
$ ./server-stats.sh

-You can install the 'mail' command in Debian-based distributions like Ubuntu by running the command:
 sudo apt-get install mailutils 
-For RPM-based distributions like CentOS, use the command:
 sudo yum install mailx 

**Create Cron Job**

You will need to frequently inspect cpu, memory and disk usage so it is advisable to create a cronjob for it. Open crontab with the following command.

$ sudo crontab -e

Add the following lines to it.

0 10 * * * ./server-stats.sh >>/opt/system.log

In the above code, we setup a cronjob that runs server-stats.sh shell script every day at 10.a.m and appends the output to /opt/system.log. You can change it as per your requirement.

This way you will have a daily record of your system information in a single file. You can simply view it with the following command.

$ sudo cat /opt/system.log

