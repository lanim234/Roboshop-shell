source common.sh
component=catalogue

nodejs

echo -e "${color}Copy MongoDB Repo File${nocolor}"
cp  /home/centos/Roboshop-shell/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>${log_file}

echo -e "${color}Install MongodDB Client${nocolor}"
yum install mongodb-org-shell -y &>>${log_file}

echo -e "${color} Load Schema${nocolor}"
mongo --host mongodb-dev.devopsb73.shop <${app_path}/schema/${component}.js &>>${log_file}
