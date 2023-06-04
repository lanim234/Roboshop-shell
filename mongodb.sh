 source common.sh
 component=mongdodb


echo -e "${color}Copy MongoDb Repo File${nocolor}"
cp home/centos/Roboshop-shell/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>${log_file}
status_check

echo -e "${color}Install MongoDB Server${nocolor}"
yum install mongodb-org -y &>>${log_file}
status_check

echo -e "${color}Update MomgoDb Listen Address${nocolor}"
sed -i  -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
status_check


echo -e "${color}Start Mongodb Server${nocolor}"
systemctl enable mongod &>>${log_file}
systemctl restart mongod &>>${log_file}
status_check