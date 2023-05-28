component=cart
color="\e[36m"







echo -e "${color} Downloading NodeJs Repos\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/roboshop.log

echo -e "${color} Downloading NodeJs\e[0m"
yum install nodejs -y &>>/tmp/roboshop.log

echo -e "${color} Adding User\e[0m"
useradd roboshop &>>/tmp/roboshop.log

echo -e "${color} Creating App Directory\e[0m"
rm -rf /app &>>/tmp/roboshop.log
mkdir /app

echo -e "${color} Downloading $component Artifacts\e[0m"
curl -o /tmp/$component.zip https://roboshop-artifacts.s3.amazonaws.com/$component.zip &>>/tmp/roboshop.log
cd /app

echo -e "${color} Unzipping Artifacts\e[0m"
unzip /tmp/$component.zip &>>/tmp/roboshop.log
cd /app

echo -e "${color} Downloading Depencies\e[0m"
npm install &>>/tmp/roboshop.log

echo -e "${color} Setting up systemD\e[0m"
cp /root/Roboshop-shell/$component.service /etc/systemd/system/$component.service &>>/tmp/roboshop.log


echo -e "${color} start $component\e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable $component &>>/tmp/roboshop.log
systemctl restart $component &>>/tmp/roboshop.log
