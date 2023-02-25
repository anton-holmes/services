#!/bin/bash
docker run -itd -p 10000:8888 -v ./data:/home/jovyan/data --restart=unless-stopped jupyter/scipy-notebook
