echo -e "\e[36m>>>>>>>>> Copy Mongo Repo <<<<<<<<<\e[0m"
cp /home/centos/KoulteghDevOps/Roboshop/mongo.repo /etc/yum.repos.d/mongo.repo

echo -e "\e[36m>>>>>>>>> Install MongoDB <<<<<<<<<\e[0m"
yum install mongodb-org -y 

echo -e "\e[36m>>>>>>>>> Start MongoDB Service <<<<<<<<<\e[0m"
systemctl enable mongod 
systemctl start mongod 

echo -e "\e[36m>>>>>>>>> Replace Listenig IP for MongoDB <<<<<<<<<\e[0m"
sed -i -e 's/127\.0\.0\.1/0.0.0.0/g' /etc/mongod.conf

echo -e "\e[36m>>>>>>>>> Restart Mongodb <<<<<<<<<\e[0m"
systemctl restart mongod