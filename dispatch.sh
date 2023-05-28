echo -e "\e[32m Downlaoding GoLang\e[0m"
yum install golang -y &>>/tmp/roboshop.log

echo -e "\e[32m Creating App user\e[0m"
useradd roboshop &>>/tmp/roboshop.log

echo -e "\e[32m Creating App Directory & Downlaoding Artifacts\e[0m"
mkdir /app
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch.zip &>>/tmp/roboshop.log

echo -e "\e[32m  Extracting Artifacts\e[0m"
cd /app
unzip /tmp/dispatch.zip &>>/tmp/roboshop.log

echo -e "\e[32m Downloading Dependencies\e[0m"
cd /app
go mod init dispatch &>>/tmp/roboshop.log
go get &>>/tmp/roboshop.log
go build &>>/tmp/roboshop.log

echo -e "\e[36m Setting up SystemD\e[0m"
cd /home/centos/Roboshop-shell/dispatch.service /etc/systemd/system/dispatch.service &>>/tmp/roboshop.log

echo -e "\e[32m Restarting Dispatch\e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable dispatch &>>/tmp/roboshop.log
systemctl start dispatch &>>/tmp/roboshop.log




