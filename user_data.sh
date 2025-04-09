#!/bin/bash

yum update -y
yum install -y httpd 
sudo systemctl start httpd && sudo systemctl enable httpd