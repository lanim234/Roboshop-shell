source common.sh
component=frontend



echo -e "${color}Install Nginx${nocolor}"
yum install nginx -y &>>${log_file)

status_check

app_presetup

status_check

echo -e "${color}Update Frontend Info${nocolor}"
cp /home/centos/Roboshop-shell/roboshop.conf /etc/nginx/default.d/roboshop.conf &>>${log_file)

#empty line
systemD_setup

status_check
