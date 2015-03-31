Zeppelin Authentication with Docker
===================================

[Apache Zeppelin](https://zeppelin.incubator.apache.org/) is a notebook for [Apache Spark](http://spark.apache.org/).  Zeppelin doesn't support authentication, a requirement for multi-user environments.  This is an attempt to use nginx and Docker containers to provide simple password-basd authentication.

Create Password File
--------------------

    $ cd nginx_docker
    $ htpasswd -cb htpasswd [user] [password]

Build Docker Containers
-----------------------

    $ cd zeppelin_docker
	$ docker build -t rnowling/zeppelin .
	$ cd ../nginx_docker
	$ docker build -t rnowling/nginx .

Run Docker Containers
---------------------

	$ docker run -d --name zeppelin rnowling/zeppelin
	$ docker run -d --name nginx --link zeppelin:zeppelin -p 8080:8080 -p 8081:8081 rnowling/nginx

Now, point your browser to http://localhost:8080/

Note that you will have to authenticate twice. :(  This may not be fixable according to [this post](http://serverfault.com/questions/558988/sharing-authentication-data-between-servers-in-nginx).
	


