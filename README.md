Zeppelin Authentication with Docker
===================================

[Apache Zeppelin](https://zeppelin.incubator.apache.org/) is a notebook for [Apache Spark](http://spark.apache.org/).  Zeppelin doesn't support authentication, a requirement for multi-user environments.  This is an attempt to use nginx and Docker containers to provide simple password-basd authentication.

Create Password File
--------------------
A basic password file is needed for authentication.  I don't distribute one with the containers, so you'll need to create one.

    $ cd nginx_docker
    $ htpasswd -cb htpasswd [user] [password]

Update Zeppelin Environment File
--------------------------------
If you need to change the Zeppelin environment file (say to point it at a cluster), modify `zeppelin_docker/zeppelin-env.sh` before building the containers.

Change Ports
------------
Each instance of Zeppelin will need its own ports.  The default ports are 8080 and 8081.  If you want to use different ports, you will need to:

1. Update `zeppelin_docker/zeppelin-site.xml`
2. Update the exposed ports in `zeppelin_docker/Dockerfile`
3. Update the exposed ports in `nginx_docker/Dockerfile`
4. Update the ports in `nginx_docker/nginx.conf`
5. Update `ZEPPELIN_PORT_8080_TCP_ADDR` in `nginx_docker/run.sh`

Note that the ports must all agree.

Build Docker Containers
-----------------------

    $ cd zeppelin_docker
	$ docker build -t rnowling/zeppelin .
	$ cd ../nginx_docker
	$ docker build -t rnowling/nginx .

Run Docker Containers
---------------------

	$ docker run -d --name rnowling-zeppelin rnowling/zeppelin
	$ docker run -d --name nginx --link rnowling-zeppelin:zeppelin -p 8080:8080 -p 8081:8081 -v /local/notebook/path:/zeppelin/notebook rnowling/nginx

Now, point your browser to [http://localhost:8080/]

Known Issues
------------
Note that you will have to authenticate twice. :(  This may not be fixable according to [this post](http://serverfault.com/questions/558988/sharing-authentication-data-between-servers-in-nginx).
	


