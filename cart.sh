component=cart
color="\e[32m"
nocolor="\e[0m"
log_file="/tmp/roboshop.log"
app_path="/app"






echo -e "${color} Downloading NodeJs Repos${nocolor}"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${log_file}

echo -e "${color} Downloading NodeJs${nocolor}"
yum install nodejs -y &>>${log_file}

echo -e "${color} Adding User${nocolor}"
useradd roboshop &>>${log_file}

echo -e "${color} Creating App Directory${nocolor}"
rm -rf ${app_path} &>>${log_file}
mkdir ${app_path}

echo -e "${color} Downloading $component Artifacts${nocolor}"
curl -o /tmp/$component.zip https://roboshop-artifacts.s3.amazonaws.com/$component.zip &>>${log_file}
cd ${app_path}

echo -e "${color} Unzipping Artifacts${nocolor}"
unzip /tmp/$component.zip &>>${log_file}
cd ${app_path}

echo -e "${color} Downloading Depencies${nocolor}"
npm install &>>${log_file}

echo -e "${color} Setting up systemD${nocolor}"
cp /root/Roboshop-shell/$component.service /etc/systemd/system/$component.service &>>${log_file}


echo -e "${color} start $component${nocolor}"
systemctl daemon-reload &>>${log_file}
systemctl enable $component &>>${log_file}
systemctl restart $component &>>${log_file}
