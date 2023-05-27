echo -e "\e[36m Installing Maven\e[0m"
yum install maven -y &>>/tmp/roboshop.log

echo -e "\e[36m Adding user\e[0m"
useradd roboshop &>>/tmp/roboshop.log

echo -e "\e[36m creating App directory\e[0m"
rm -rf /app &>>/tmp/roboshop.log
mkdir /app

echo -e "\e[36m Downloading Shipping Artifacts\e[0m"
curl -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip &>>/tmp/roboshop.log


echo -e "\e[36m Unzipping file\e[0m"
cd /app
unzip /tmp/shipping.zip &>>/tmp/roboshop.log

echo -e "\e[36m Download Dependencies\e[0m"
cd /app
mvn clean package &>>/tmp/roboshop.log
mv target/shipping-1.0.jar shipping.jar &>>/tmp/roboshop.log

echo -e "\e[36m Setup SystemD file\e[0m"
cp /home/centos/Roboshop-shell/shipping.service /etc/systemd/system/shipping.service &>>/tmp/roboshop.log

echo -e "\e[36m Installing MySQL Client\e[0m"
yum install mysql -y &>>/tmp/roboshop.log

echo -e "\e[36m Load Schema\e[0m"
mysql -h mysql-dev.devopsb73.shop -uroot -pRoboShop@1 < /app/schema/shipping.sql &>>/tmp/roboshop.log

echo -e "\e[36m Start Shipping\e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable shipping &>>/tmp/roboshop.log
systemctl restart shipping &>>/tmp/roboshop.log