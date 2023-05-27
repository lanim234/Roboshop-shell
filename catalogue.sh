echo -e "\e[31mDownload Repo\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/roboshop.log

echo -e "\e[31mInstalling NodeJs\e[0m"
yum install nodejs -y &>>/tmp/roboshop.log

echo -e "\e[31mAdding User\e[0m"
useradd roboshop &>>/tmp/roboshop.log

echo -e "\e[31mCreate Application Directory\e[0m"
rm -rf /app &>>/tmp/roboshop.log
mkdir /app

echo -e "\e[31mDownload Catalogue Artifacts\e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>/tmp/roboshop.log
cd /app

echo -e "\e[31mExtract Application Content\e[0m"
unzip /tmp/catalogue.zip &>>/tmp/roboshop.log
cd /app

echo -e "\e[31m Install NodeJS Dependencies\e[0m"
npm install &>>/tmp/roboshop.log

echo -e "\e[31mSet up SystemD Service\e[0m"
cp  /home/centos/Roboshop-shell/catalogue.service /etc/systemd/system/catalogue.service &>>/tmp/roboshop.log

echo -e "\e[31mStart Catalogue Service\e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable catalogue &>>/tmp/roboshop
systemctl start catalogue &>>/tmp/roboshop.log

echo -e "\e[31mCopy MongoDB Repo File\e[0m"
cp  /home/centos/Roboshop-shell/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>/tmp/roboshop.log

echo -e "\e[31mInstall MongodDB Client\e[0m"
yum install mongodb-org-shell -y &>>/tmp/roboshop.log

echo -e "\e[31m Load Schema\e[0m"
mongo --host mongodb-dev.devopsb73.shop </app/schema/catalogue.js &>>/tmp/roboshop.log
