#!/bin/bash
sudo apt update
sudo apt install software-properties-common  -y
sudo apt-add-repository ppa:ansible/ansible -y
sudo apt install ansible -y
sudo apt-get install apt-transport-https ca-certificates curl -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" -y
sudo apt install docker-ce -y
sudo systemctl enable docker && sudo systemctl start docker

#cat << STOP >> /var/www/html/index.html
#<html>
#<head>
#    <title>My Webpage</title>
#    <style>
#        body {
#            background-color: black;
#            display: flex;
#            justify-content: center;
#            align-items: center;
#            height: 100vh;
#            margin: 0;
#        }
#        h1 {
#            color: red;
#            font-size: 48px;
#            font-weight: bold;
#            text-align: center;
#        }
#    </style>
#</head>
#<body>
#    <h1>Powered by Terraform</h1>
#</body>
#</html>
