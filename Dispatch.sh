echo -e "\e[32m Downlaoding GoLang\e[0m"
yum install golang -y

echo -e "\e[32m Creating App user\e[0m"
useradd roboshop

echo -e "\e[32m Creating App Directory & Downlaoding Artifacts\e[0m"
mkdir /app
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch.zip

echo -e "\e[32m  Extracting Artifacts\e[0m"
cd /app
unzip /tmp/dispatch.zip

echo -e "\e[32m Downloading Dependencies\e[0m"
cd /app
go mod init dispatch
go get
go build

echo -e "\e[36m Setting up SystemD\e[0m"
cd /home/centos/Roboshop-shell/Dispatch.service /etc/systemd/system/dispatch.service

echo -e "\e[32m Restarting Dispatch\e[0m"
systemctl daemon-reload
systemctl enable dispatch
systemctl start dispatch




