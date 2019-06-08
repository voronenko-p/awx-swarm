

Initialize swarm (manual scenario)

Login to master host

```

docker swarm init --advertise-addr 192.168.57.101
Swarm initialized: current node (bdtkob8vifuploc0ut7vgojpi) is now a manager.

To add a worker to this swarm, run the following command:

    docker swarm join --token SWMTKN-1-54jsoe57kwu4pakg3u5jfov0kg2enovbsdmuklw290ilfu8z57-58792yz2r8a18x5xqdi5siopc 192.168.57.101:2377

To add a manager to this swarm, run 'docker swarm join-token manager' and follow the instructions.


```

After that on each of runners, join swarm as runner

```

    docker swarm join --token SWMTKN-1-54jsoe57kwu4pakg3u5jfov0kg2enovbsdmuklw290ilfu8z57-58792yz2r8a18x5xqdi5siopc 192.168.57.101:2377

```


If you are looking for some UI

```yaml
version: '3'

services:
 app:
   image: swarmpit/swarmpit:1.2
   environment:
     SWARMPIT_DB: http://db:5984
   volumes:
      - /var/run/docker.sock:/var/run/docker.sock:ro
   ports:
     - 888:8080
   networks:
     - net
   deploy:
     placement: 
       constraints:
         - node.role == manager
 db:
   image: klaemo/couchdb:2.0.0
   volumes:
     - db-data:/opt/couchdb/data
   networks:
     - net

networks:
   net:
     driver: overlay

volumes:
   db-data:
     driver: local
```

Once initialized - can be observed via http://192.168.57.101:888/#/nodes

Default creds pair, if left uninitialized admin/admin


Cross nodes network

```
docker network create --driver overlay --subnet=10.0.9.0/24 wordpress
```

Our previous demo can be natively deployed to swarm with slightly modified command

```
docker stack deploy traefik --compose-file docker-compose.yml
```

and traefik dashboard can be accessed on every runner you've configured, like

```
http://192.168.57.101:18080/dashboard/
http://192.168.57.102:18080/dashboard/
http://192.168.57.103:18080/dashboard/
``

```
docker stack deploy someportal --compose-file docker-compose.yml


Creating network someportal_default
Creating service someportal_code-server
Creating service someportal_mariadb
Creating service someportal_wordpress

```


Traefik with consul

https://docs.traefik.io/user-guide/cluster-docker-consul/

