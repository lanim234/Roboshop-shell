color="\e[36m"
nocolor="\e[0m"
log_file="/tmp/roboshop.log"
app_path="/app"


app_presetup() {
  echo -e "${color}Adding User${nocolor}"
  useradd roboshop &>>${log_file}

rm -rf ${app_path} &>>${log_file}
mkdir ${app_path}

echo -e "${color} Downloading ${component} Artifacts${nocolor}"
  curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>${log_file}

echo -e "${color}Extract Application Content${nocolor}"
cd ${app_path}
unzip /tmp/${component}.zip &>>${log_file}

}


systemD_setup() {
  echo -e "${color}Set up SystemD Service${nocolor}"
  cp  /home/centos/Roboshop-shell/${component}.service /etc/systemd/system/${component}.service &>>${log_file}

  echo -e "${color}Start ${component} Service${nocolor}"
  systemctl daemon-reload &>>${log_file}
  systemctl enable ${component} &>>${log_file}
  systemctl start ${component} &>>${log_file}

}


mysql_schema_setup() {
echo -e "${color} Installing MySQL Client${nocolor}"
  yum install mysql -y &>>${log_file}

  echo -e "${color} Load Schema${nocolor}"
  mysql -h mysql-dev.devopsb73.shop -uroot -pRoboShop@1 < /schema/${component}.sql &>>${log_file}


}
nodejs() {
echo -e "${color}Download Repo${nocolor}"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${log_file}

echo -e "${color}Installing NodeJs${nocolor}"
yum install nodejs -y &>>${log_file}

app_presetup


echo -e "${color} Install NodeJS Dependencies${nocolor}"
npm install &>>${log_file}

systemD_setup
}


mongo_schema_setup() {

echo -e "${color}Copy MongoDB Repo File${nocolor}"
cp  /home/centos/Roboshop-shell/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>${log_file}

echo -e "${color}Install MongodDB Client${nocolor}"
yum install mongodb-org-shell -y &>>${log_file}

echo -e "${color} Load Schema${nocolor}"
mongo --host mongodb-dev.devopsb73.shop <${app_path}/schema/${component}.js &>>${log_file}

}


maven() {
  echo -e "${color} Installing Maven${nocolor}"
  yum install maven -y &>>${log_file}

  app_presetup

  echo -e "${color} Download Dependencies${nocolor}"
  mvn clean package &>>${log_file}
  mv target/${component}-1.0.jar ${component}.jar &>>${log_file}


mysql_schema_setup
systemD_setup
}