app_user=roboshop
script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh
log_file=/tmp/roboshop.log
# rm -f &>>$log_file

func_print_head() {
  echo -e "\e[36m>>>>>>>>> $1 <<<<<<<<<\e[0m"
  echo -e "\e[36m>>>>>>>>> $1 <<<<<<<<<\e[0m" &>>$log_file
}

func_status_check() {
  if [ $1 -eq 0 ]; then
    echo -e "\e[32mSUCCESS\e[0m"
  else
    echo -e "\e[31mFAILURE\e[0m"
    echo refer to /tmp/roboshop.log file for more information
    exit 1
  fi
}

func_schema_setup() {
  if [ "$func_schema_setup" == "mongo" ]; then
    func_print_head "Copy MongoDB Repo" 
    cp ${script_path}/mongo.repo /etc/yum.repos.d/mongo.repo &>>$log_file
    func_status_check $?

    func_print_head "Installing MongoDB Client" 
    yum install mongodb-org-shell -y &>>$log_file
    func_status_check $?

    func_print_head "Load Schema" 
    mongo --host mongodb-dev.gilbraltar.co.uk </app/schema/${component}.js &>>$log_file
    func_status_check $?
  fi 
  if [ "$func_schema_setup" == "mysql" ]; then
    func_print_head "Install MySQL" 
    yum install mysql -y &>>$log_file
    func_status_check $? 

    func_print_head "Load Schema" 
    mysql -h mysql-dev.gilbraltar.co.uk -uroot -p${mysql_root_password} < /app/schema/${component}.sql &>>$log_file
    func_status_check $?
  fi
}

func_app_prereq() {
  func_print_head "Create Application User"
  if [ $? -ne 0 ]; then
    useradd ${app_user} &>>$log_file
  fi 
  func_status_check $?

  func_print_head "Create Application Directory" 
  rm -rf /app &>>$log_file
  mkdir /app &>>$log_file
  func_status_check $?

  func_print_head "Download Application Content" 
  curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>$log_file
  func_status_check $?

  func_print_head "Extract Application Content" 
  cd /app &>>$log_file
  unzip /tmp/${component}.zip &>>$log_file
  func_status_check $?

  # cd /app 
}

func_systemd_setup() {
  func_print_head "Setup SystemD Service" 
  cp ${script_path}/${component}.service /etc/systemd/system/${component}.service &>>$log_file
  func_status_check $?
  # cp ${component}.service /etc/systemd/system/${component}.service

  func_print_head "Start ${component} Service" 
  systemctl daemon-reload &>>$log_file
  systemctl enable ${component} &>>$log_file 
  systemctl start ${component} &>>$log_file
  func_status_check $?
}

func_nodejs() {
  func_print_head "Configure NodeJS Repos" 
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>$log_file
  func_status_check $?

  func_print_head "Install NodeJS" 
  yum install nodejs -y &>>$log_file
  func_status_check $?

  func_app_prereq

  func_print_head "Install NodeJS Dependencies" 
  npm install &>>$log_file
  func_status_check $?
  
  func_schema_setup 

  func_systemd_setup
}

func_java() {
  func_print_head "Install Maven" 
  yum install maven -y &>>$log_file
  func_status_check $?

  func_app_prereq

  func_print_head "Download Maven Dependencies" 
  mvn clean package &>>$log_file
  func_status_check $?
  # if [ $1 -eq 0 ]; then
  #   echo -e "\e[32mSUCCESS\e[0m"
  # else
  #   echo -e "\e[31mFAILURE\e[0m"
  #   exit
  # fi

  mv target/${component}-1.0.jar ${component}.jar &>>$log_file

  func_schema_setup

  func_systemd_setup
}

func_python() {
  func_print_head "Install Python36" 
  yum install python36 gcc python3-devel -y &>>$log_file
  func_status_check $?

  func_app_prereq

  # func_print_head "Create Application User"
  # useradd ${app_user}

  # func_print_head "Create Application Directory" 
  # rm -rf /app
  # mkdir /app 

  # func_print_head "Download Application File" 
  # curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip 
  # cd /app 

  # func_print_head "Unzip Application Content"
  # unzip /tmp/${component}.zip
  # # cd /app 

  func_print_head "Install ${component} Dependencies" 
  pip3.6 install -r requirements.txt &>>$log_file
  func_status_check $?
  
  func_print_head "Update Password in System Service File"
  sed -i -e "s|rabbitmq_appuser_password|${rabbitmq_appuser_password}|" ${script_path}/${component}.service &>>$log_file
  func_status_check $?
  
  func_systemd_setup
  # func_print_head "Copy ${component} Service File"
  # cp ${script_path}/${component}.service /etc/systemd/system/${component}.service
  # # cp ${component}.service /etc/systemd/system/${component}.service

  # func_print_head "Start ${component} Service" 
  # systemctl daemon-reload
  # systemctl enable ${component} 
  # systemctl start ${component}
}
