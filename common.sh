color="\e[36m"
nocolor="\e[0m"
log_file="/tmp/roboshop.log"
app_path="/app"


status_check() {
if [ $? -eq 0 ]; then
  echo "SUCCESS"
else
  echo "FAILURE"
fi
}



app_presetup() {
  echo -e "${color}Adding User${nocolor}"
  id roboshop &>>${log_file}
  if [ $? -eq 1 ]; then
    useradd roboshop &>>${log_file}
    fi

status_check

rm -rf ${app_path} &>>${log_file}
mkdir ${app_path}

echo -e "${color} Downloading ${component} Artifacts${nocolor}"
  curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>${log_file}

status_check

cd ${app_path}
echo -e "${color}Extract Application Content${nocolor}"
unzip /tmp/${component}.zip &>>${log_file}

status_check
}


systemD_setup() {
  echo -e "${color}Set up SystemD Service${nocolor}"
  cp /home/centos/Roboshop-shell/${component}.service /etc/systemd/system/${component}.service &>>${log_file}
  sed -i -e "s/roboshop_app_password/$roboshop_app_password/" /etc/systemd/system/$component.service

status_check

  echo -e "${color}Start ${component} Service${nocolor}"
  systemctl daemon-reload &>>${log_file}
  systemctl enable ${component} &>>${log_file}
  systemctl start ${component} &>>${log_file}

status_check
}


mysql_schema_setup() {
  systemD_setup

echo -e "${color} Installing MySQL Client${nocolor}"
  yum install mysql -y &>>${log_file}

status_check

  echo -e "${color} Load Schema${nocolor}"
  mysql -h mysql-dev.devopsb73.shop -uroot -pRoboShop@1 < /{app_path}/schema/${component}.sql &>>${log_file}

status_check
}


nodejs() {
echo -e "${color}Download Repo${nocolor}"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${log_file}

status_check


echo -e "${color}Installing NodeJs${nocolor}"
yum install nodejs -y &>>${log_file}

status_check

app_presetup

status-check

echo -e "${color} Install NodeJS Dependencies${nocolor}"
npm install &>>${log_file}

status_check

systemD_setup

status_check


}




mongo_schema_setup() {

echo -e "${color}Copy MongoDB Repo File${nocolor}"
cp  /home/centos/Roboshop-shell/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>${log_file}

status_check

echo -e "${color}Install MongodDB Client${nocolor}"
yum install mongodb-org-shell -y &>>${log_file}

status_check


echo -e "${color} Load Schema${nocolor}"
mongo --host mongodb-dev.devopsb73.shop <${app_path}/schema/${component}.js &>>${log_file}

status_check

}


 maven() {
  echo -e "${color} Installing Maven${nocolor}"
  yum install maven -y &>>${log_file}

status_check


  app_presetup

status_check

  echo -e "${color} Download Dependencies${nocolor}"
  mvn clean package &>>${log_file}
  mv target/${component}-1.0.jar ${component}.jar &>>${log_file}

status_check


mysql_schema_setup

status_check

systemD_setup

status_check

}


 python_setup() {
  echo -e "${color} Installing Python${nocolor}"
  yum install python36 gcc python3-devel -y &>>${log_file}

status_check

  app_presetup

status_check

  echo -e "${color} Installing Repos${nocolor}"
  pip3.6 install -r requirements.txt &>>${log_file}
  cd ${app_path}

status_check

sed -i -e "s/roboshop_app_password/$1/" /home/centos/roboshop-shell/$component.service

status_check

systemD_setup

status_check

}