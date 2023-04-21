echo -e "\e[36m>>>>>>>>> Install RabbitMQ Repo <<<<<<<<<\e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash

echo -e "\e[36m>>>>>>>>> Install Erland <<<<<<<<<\e[0m"
yum install erlang -y

echo -e "\e[36m>>>>>>>>> Download RabbitMQ File <<<<<<<<<\e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash

echo -e "\e[36m>>>>>>>>> Install RabbitMQ Server <<<<<<<<<\e[0m"
yum install rabbitmq-server -y 

echo -e "\e[36m>>>>>>>>> Start RabbitMQ <<<<<<<<<\e[0m"
systemctl enable rabbitmq-server 
systemctl start rabbitmq-server 

echo -e "\e[36m>>>>>>>>> Set User Password <<<<<<<<<\e[0m"
rabbitmqctl add_user roboshop roboshop123
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"