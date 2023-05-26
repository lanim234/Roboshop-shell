echo -e "\e[33mInstall Nginx\e[0m"
yum install nginx -y >/tmp/roboshop.log

echo -e "\e[33mRemoving Old App Content\e[0m"
rm -rf /usr/share/nginx/html/* >/tmp/roboshop.log

echo -e "\e[33mDownloading Frontend\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip >/tmp/roboshop.log

echo -e "\e[33mExtract Frontend\e[0m"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip >/tmp/roboshop.log

##vim /etc/nginx/default.d/roboshop.conf

echo -e "\e[33mRestart Nginx\e[0m"
systemctl enable nginx >/tmp/roboshop.log
systemctl restart nginx >/tmp/roboshop.log