echo -e "\e[35m Downloading Repos\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/roboshop.log

echo -e "\e[35m Installing Nodejs\e[0m"
yum install nodejs -y &>>/tmp/roboshop.log

echo -e "\e[35m Adding user\e[0m"
useradd roboshop &>>/tmp/roboshop.log

echo -e "\e[35m Create Application Directory\e[0m"
rm -rf /app &>>/tmp/roboshop.log
mkdir /app &>>/tmp/roboshop.log

echo -e "\e[35m Download Application Content\e[0m"
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip &>>/tmp/roboshop.log
cd /app

echo -e "\e[35m Extract Application Content\e[0m"
unzip /tmp/user.zip &>>/tmp/roboshop.log
cd /app

echo -e "\e[35m Installing NodeJs Dependencies\e[0m"
npm install &>>/tmp/roboshop.log

echo -e "\e[35m Setup SystemD Service \e[0m"
cp /home/centos/Roboshop-shell/user.service /etc/systemd/system/user.service &>>/tmp/roboshop.log

echo -e "\e[35m Enable system restart\e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable user &>>/tmp/roboshop.log
systemctl start user &>>/tmp/roboshop.log

echo -e "\e[35m Copy MongoDB repo file\e[0m"
cp /home/centos/Roboshop-shell/mongodb.repo /etc/yum.repos.d/mongo.repo &>>/tmp/roboshop.log

echo -e "\e[35m Installing MongoDB client\e[0m"
yum install mongodb-org-shell -y &>>/tmp/roboshop.log

echo -e "\e[35m Loading Schema\e[0m"
mongo --host mongodb-dev.devopsb73.shop</app/schema/user.js &>>/tmp/roboshop.log