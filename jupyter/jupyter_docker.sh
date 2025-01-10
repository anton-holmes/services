#!/bin/bash
sudo docker run -itd -p 10000:8888 -v ./data:/home/jovyan/data -e GRANT_SUDO=yes --restart=unless-stopped  quay.io/jupyter/datascience-notebook:lates
