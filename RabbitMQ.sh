source common.sh
component=shipping




echo -e "${color} Configuring Erlang Repo${nocolor}"
curl -s https://packagecloud.io/install/repositories/${component}/erlang/script.rpm.sh | bash &>>${log_file}

echo -e "${color} Configuring Yum Repos for ${component}${nocolor}"
curl -s https://packagecloud.io/install/repositories/${component}/${component}-server/script.rpm.sh | bash &>>${log_file}

echo -e "${color} Installing ${component}${nocolor}"
yum install ${component}-server -y &>>${log_file}

systemD_setup

echo -e "${color} Create User and permission${nocolor}"
${component}ctl add_user roboshop roboshop123 &>>${log_file}
${component}ctl set_permissions -p / roboshop ".*" ".*" ".*" &>>${log_file}