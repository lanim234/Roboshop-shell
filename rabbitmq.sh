source common.sh
component=rabbitmq



echo -e "${color} Configuring Erlang Repo${nocolor}"
curl -s https://packagecloud.io/install/repositories/${component}/erlang/script.rpm.sh | bash &>>${log_file}
status check

echo -e "${color} Configuring Yum Repos for ${component}${nocolor}"
curl -s https://packagecloud.io/install/repositories/${component}/${component}-server/script.rpm.sh | bash &>>${log_file}
status check


echo -e "${color} Installing ${component}${nocolor}"
yum install ${component}-server -y &>>${log_file}
status check

systemD_setup
status check


echo -e "${color} Create User and permission${nocolor}"
${component}ctl add_user roboshop roboshop123 &>>${log_file}
${component}ctl set_permissions -p / roboshop ".*" ".*" ".*" &>>${log_file}
status check