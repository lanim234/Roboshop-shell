component=catalogue
color="\e[33m"
nocolor="\e[0m"


echo -e "${color}Download Repo${nocolor}"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/roboshop.log

echo -e "${color}Installing NodeJs${nocolor}"
yum install nodejs -y &>>/tmp/roboshop.log

echo -e "${color}Adding User${nocolor}"
useradd roboshop &>>/tmp/roboshop.log

echo -e "${color}Create Application Directory${nocolor}"
rm -rf /app &>>/tmp/roboshop.log
mkdir /app

echo -e "${color}Download $component Artifacts${nocolor}"
curl -o /tmp/$component.zip https://roboshop-artifacts.s3.amazonaws.com/$component.zip &>>/tmp/roboshop.log
cd /app

echo -e "${color}Extract Application Content${nocolor}"
unzip /tmp/$component.zip &>>/tmp/roboshop.log
cd /app

echo -e "${color} Install NodeJS Dependencies${nocolor}"
npm install &>>/tmp/roboshop.log

echo -e "${color}Set up SystemD Service${nocolor}"
cp  /home/centos/Roboshop-shell/$component.service /etc/systemd/system/$component.service &>>/tmp/roboshop.log

echo -e "${color}Start $component Service${nocolor}"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable $component &>>/tmp/roboshop
systemctl start $component &>>/tmp/roboshop.log

echo -e "${color}Copy MongoDB Repo File${nocolor}"
cp  /home/centos/Roboshop-shell/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>/tmp/roboshop.log

echo -e "${color}Install MongodDB Client${nocolor}"
yum install mongodb-org-shell -y &>>/tmp/roboshop.log

echo -e "${color} Load Schema${nocolor}"
mongo --host mongodb-dev.devopsb73.shop </app/schema/$component.js &>>/tmp/roboshop.log
