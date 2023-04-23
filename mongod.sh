script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh

func_print_head "Copy Mongo Repo" 
cp ${script_path}/mongo.repo /etc/yum.repos.d/mongo.repo

func_print_head "Install MongoDB" 
yum install mongodb-org -y 

func_print_head "Start MongoDB Service" 
systemctl enable mongod 
systemctl start mongod 

func_print_head "Replace Listenig IP for MongoDB" 
sed -i -e 's/127\.0\.0\.1/0.0.0.0/g' /etc/mongod.conf

func_print_head "Restart Mongodb"
systemctl restart mongod