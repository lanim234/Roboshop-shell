echo -e "\e[35m Installing Python\e[0m"
yum install python36 gcc python3-devel -y

echo -e "\e[35m Creating App user\e[0m"
useradd roboshop

echo -e "\e[35m Create a drirectory\e[0m"
mkdir /app

echo -e "\e[35m Downloading Payment Artifacts\e[0m"
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip


echo -e "\e[35m Extracting Artifacts\e[0m"
cd /app
unzip /tmp/payment.zip

echo -e "\e[35m Installing Repos\e[0m"
cd /app
pip3.6 install -r requirements.txt


echo -e "\e[35m Setting Up SystemD\e[0m"
cp /home/centos/Roboshop-shell/Payment.service /etc/systemd/system/payment.service

echo -e "\e[35m Restarting payment\e[0m"
systemctl daemon-reload
systemctl enable payment
systemctl start payment