script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh
rabbitmq_appuser_password=$1

if [ -z "$rabbitmq_appuser_password" ]; then
    echo Input RabbitMQ Appuser Password Missing &>>$log_file
    exit 1
fi

func_print_head "Install RabbitMQErlang Repo" 
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash &>>$log_file
func_status_check $?

func_print_head "Download RabbitMQ File/Repo"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash &>>$log_file
func_status_check $?

func_print_head "Install Erland"
yum install erlang -y &>>$log_file
func_status_check $?

func_print_head "Install RabbitMQ Server" 
yum install rabbitmq-server -y &>>$log_file
func_status_check $?

func_print_head "Start RabbitMQ Service"
systemctl enable rabbitmq-server &>>$log_file
systemctl start rabbitmq-server &>>$log_file
func_status_check $?

func_print_head "Add Application User in RabbitMQ" 
rabbitmqctl add_user roboshop ${rabbitmq_appuser_password} &>>$log_file
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>$log_file
func_status_check $?