script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh
rabbitmq_appuser_password=$1

if [ -z "$rabbitmq_appuser_password" ]; 
then
    echo Input RabbitMQ Appuser Password Missing
    exit
fi

print_head "Install RabbitMQ Repo" 
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash

print_head "Install Erland & RabbitMQ"
yum install erlang -y

print_head "Download RabbitMQ File"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash

print_head "Install RabbitMQ Server" 
yum install rabbitmq-server -y 

print_head "Start RabbitMQ"
systemctl enable rabbitmq-server 
systemctl start rabbitmq-server 

print_head "Set User Password" 
rabbitmqctl add_user roboshop ${rabbitmq_appuser_password}
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"