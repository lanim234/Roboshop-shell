 source common.sh
 component=${payment}
 
 
echo -e "${color} Installing Python${nocolor}"
yum install python36 gcc python3-devel -y &>>${log_file}

echo -e "${color} Creating App user${nocolor}"
useradd roboshop &>>${log_file}

echo -e "${color} Create a drirectory${nocolor}"
mkdir ${app_path}

echo -e "${color} Downloading ${component} Artifacts${nocolor}"
curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>${log_file}


echo -e "${color} Extracting Artifacts${nocolor}"
cd ${app_path}
unzip /tmp/${component}.zip &>>${log_file}

echo -e "${color} Installing Repos${nocolor}"
cd ${app_path}
pip3.6 install -r requirements.txt &>>${log_file}


echo -e "${color} Setting Up SystemD${nocolor}"
cp /home/centos/Roboshop-shell/${component}.service /etc/systemd/system/${component}.service &>>${log_file}

echo -e "${color} Restarting ${component}${nocolor}"
systemctl daemon-reload &>>${log_file}
systemctl enable ${component} &>>${log_file}
systemctl start ${component} &>>${log_file}