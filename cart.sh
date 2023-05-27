echo -e "\e[35m Downloading NodeJs Repos\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/roboshop.log

echo -e "\e[35m Downloading NodeJs\e[0m"
yum install nodejs -y &>>/tmp/roboshop.log

echo -e "\e[35m Adding User\e[0m"
useradd roboshop &>>/tmp/roboshop.log

echo -e "\e[35m Creating App Directory\e[0m"
rm -rf /app &>>/tmp/roboshop.log
mkdir /app

echo -e "\e[35m Downloading Cart Artifacts\e[0m"
curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip &>>/tmp/roboshop.log
cd /app

echo -e "\e[35m Unzipping Artifacts\e[0m"
unzip /tmp/cart.zip &>>/tmp/roboshop.log
cd /app

echo -e "\e[35m Downloading Depencies\e[0m"
npm install &>>/tmp/roboshop.log

echo -e "\e[35m Setting up systemD\e[0m"
cp /home/centos/Roboshop-shell/cart.service /etc/systemd/system/cart.service &>>/tmp/roboshop.log

echo -e "\e[35m start Cart\e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable &>>/tmp/roboshop.log
systemctl restart &>>/tmp/roboshop.log
