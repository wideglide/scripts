#!/bin/bash

sudo apt-get update
sudo apt-get install software-properties-common nginx
sudo add-apt-repository universe
sudo add-apt-repository ppa:certbot/certbot
sudo apt-get update
sudo apt-get install certbot python-certbot-nginx 

sudo certbot --nginx
