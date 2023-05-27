echo -e "\e[36m Disable MySQL Version 8\e[0m"
yum module disable mysql -y &>>/tmp/roboshop.log

echo -e "\e[36m Copy MySQL repo file\e[0m"
cp /root/Roboshop-shell/mysql.repo /etc/yum.repos.d/mysql.repo


echo -e "\e[36m Installing mySQL\E[0m"
yum install mysql-community-server -y &>>/tmp/roboshop.log

echo -e "\e[36m Start mySQL\e[0m"
systemctl enable mysqld &>>/tmp/roboshop.log
systemctl start mysqld &>>/tmp/roboshop.log

echo -e "\e[36m Set password\e[360m"
mysql_secure_installation --set-root-pass RoboShop@1 &>>/tmp/roboshop.log


