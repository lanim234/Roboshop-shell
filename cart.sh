component=cart
color="\e[36m"
nocolor="\e[0m"
log file="/tmp/roboshop.log"
app path="/app"






echo -e "${color} Downloading NodeJs Repos${nocolor}"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/${log file}

echo -e "${color} Downloading NodeJs${nocolor}"
yum install nodejs -y &>>${log file}

echo -e "${color} Adding User${nocolor}"
useradd roboshop &>>${log file}

echo -e "${color} Creating App Directory${nocolor}"
rm -rf ${app path} &>>${log file}
mkdir ${app path}

echo -e "${color} Downloading $component Artifacts${nocolor}"
curl -o /tmp/$component.zip https://roboshop-artifacts.s3.amazonaws.com/$component.zip &>>${log file}
cd ${app path}

echo -e "${color} Unzipping Artifacts${nocolor}"
unzip /tmp/$component.zip &>>${log file}
cd ${app path}

echo -e "${color} Downloading Depencies${nocolor}"
npm install &>>${log file}

echo -e "${color} Setting up systemD${nocolor}"
cp /root/Roboshop-shell/$component.service /etc/systemd/system/$component.service &>>${log file}


echo -e "${color} start $component${nocolor}"
systemctl daemon-reload &>>${log file}
systemctl enable $component &>>${log file}
systemctl restart $component &>>${log file}
