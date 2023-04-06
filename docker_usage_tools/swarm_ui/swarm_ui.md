minikube@minikube:~$ docker swarm init --advertise-addr 192.168.0.7
Swarm initialized: current node (n21n8ff3jgumqtjjc39gypd3s) is now a manager.

To add a worker to this swarm, run the following command:

    docker swarm join --token SWMTKN-1-1ncn4kug8kfswn6rbfka5ido6eam720ug0vokt7okux4gakq56-59d5p0bpivr25raff2f5q7zbw 192.168.0.7:2377

To add a manager to this swarm, run 'docker swarm join-token manager' and follow the instructions.


docker run -it --rm -p 8080:8080   --name swarmpit-installer   --volume /var/run/docker.sock:/var/run/docker.sock   swarmpit/install:1.9
                                      
pplication setup
Enter stack name [swarmpit]: 
Enter application port [888]: 8080
Enter database volume driver [local]: 
Enter admin username [admin]: 
Enter admin password (min 8 characters long): 12345678

Summary
Username: admin
Password: 12345678
Swarmpit is running on port :8080


----------------------
add host
create container centos


