echo -e "\e[34mInstalling Repo\e[0m"
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y &>>/tmp/roboshop.log

echo -e "\e[34m Enable Redis 6.2\e[0m"
yum module enable redis:remi-6.2 -y &>>/tmp/roboshop.log

echo -e "\e[34m Installing Redis\e[[0m"
yum install redis -y &>>/tmp/roboshop.log

echo -e "\e[34m Installing Redis\e[[0m"
sed -i 's/127.0.0.1/0.0.0.0/' /etc/redis.conf /etc/redis/redis.conf &>>/tmp/roboshop.log

echo -e "\e[34m Start Redis\e[0m"
systemctl enable redis &>>/tmp/roboshop.log
systemctl start redis  &>>/tmp/roboshop.log