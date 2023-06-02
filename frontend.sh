source common.sh
component=frontend



echo -e "${color}Install Nginx${nocolor}"
yum install nginx -y &>>${log_file)

status_check

app_presetup

status_check


systemD_setup

status_check
#NO WAY