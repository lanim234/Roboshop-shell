echo -e "\e[31mCopy MongoDb Repo File\e[0m"
cp mongodb.repo /etc/yum.repos.d/mongodb.repo

echo -e "\e[33mInstall MongoDB Server\e[0m"
yum install mongodb-org -y

echo -e "\e[31mStart Mongodb Server\e[0m"
system enable mongodb
system restart mongod