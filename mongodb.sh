echo -e "\e[31mCopy MongoDb Repo File\e[0m"
cp home/centos/Roboshop-shell/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>/tmp/roboshop.log

echo -e "\e[33mInstall MongoDB Server\e[0m"
yum install mongodb-org -y &>>/tmp/roboshop.log

echo -e "\e[32mUpdate MomgoDb Listen Address\e[0m"
sed -i  -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf


echo -e "\e[31mStart Mongodb Server\e[0m"
systemctl enable mongod &>>/tmp/roboshop.log
systemctl restart mongod &>>/tmp/roboshop.log