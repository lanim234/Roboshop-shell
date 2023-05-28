component=catalogue
color="\e[33m"
nocolor="\e[0m"
log file="/tmp/roboshop.log"
app_path="/app"


echo -e "${color}Download Repo${nocolor}"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>$log file

echo -e "${color}Installing NodeJs${nocolor}"
yum install nodejs -y &>>$log file

echo -e "${color}Adding User${nocolor}"
useradd roboshop &>>$log file

echo -e "${color}Create Application Directory${nocolor}"
rm -rf ${app_path} &>>$log file
mkdir ${app_path}

echo -e "${color}Download $component Artifacts${nocolor}"
curl -o /tmp/$component.zip https://roboshop-artifacts.s3.amazonaws.com/$component.zip &>>$log file
cd ${app_path}

echo -e "${color}Extract Application Content${nocolor}"
unzip /tmp/$component.zip &>>$log file
cd ${app_path}

echo -e "${color} Install NodeJS Dependencies${nocolor}"
npm install &>>$log file

echo -e "${color}Set up SystemD Service${nocolor}"
cp  /home/centos/Roboshop-shell/$component.service /etc/systemd/system/$component.service &>>$log file

echo -e "${color}Start $component Service${nocolor}"
systemctl daemon-reload &>>$log file
systemctl enable $component &>>/tmp/roboshop
systemctl start $component &>>$log file

echo -e "${color}Copy MongoDB Repo File${nocolor}"
cp  /home/centos/Roboshop-shell/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>$log file

echo -e "${color}Install MongodDB Client${nocolor}"
yum install mongodb-org-shell -y &>>$log file

echo -e "${color} Load Schema${nocolor}"
mongo --host mongodb-dev.devopsb73.shop <$app_path/schema/$component.js &>>$log file
