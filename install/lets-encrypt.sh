#!/bin/bash

sudo apt-get update
sudo apt-get install software-properties-common nginx
sudo add-apt-repository universe
sudo apt-get update
sudo apt-get install python3-certbot-nginx

sudo certbot --nginx
