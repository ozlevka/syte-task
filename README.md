# Test task for Syte company
## General instructions: 
Use    python    3.6.4    and    above 
write a clear    README    file
Tasks
## 1.  Packer
build    an    image    using    packer    and    ansible    that    will    include    “echo    server”
written in python.
the    server    will    return    whatever    he    will    get    in the body,    preceded    by    the
server own IP    address and will print the request to log.
## 2.    terraform
use    the    image    built    in    section    1    to    deploy    a    cluster    of    3    instances    ready
to    serve    with    the    echo    server,    behind    LB


# Solution
The server writen with [Flask](http://flask.pocoo.org/docs/1.0/) package for small servers. You can review code into server folder.  

For running programs please install:
1. Packer v1.4.2 [more information](https://www.packer.io/intro/getting-started/install.html)
2. Terraform v0.12.3 [more information](https://learn.hashicorp.com/terraform/getting-started/install.html)

For build images just run:
```
make build
```
All images will build. 

For test application running local (in swarm cluster):
```
make run
```

Swarm cluster will be created. Into swarm cluster will run replicated service with 3 instance of server. 
And service of loadbalancer. You can review nginx config into "config" folder.
Generally in swarm we not need loadbalancer due swarm service have built in. But for clear task I built loadbalancer.

For stop swarm cluster run:
```
make stop
```

Terraform task built for DigitalOcean cloud. I just have some money on my account.

For create run:
```
make tfapply
```

You will be asked for DigitalOcean token. 

For destroy run:
```
make tfdestroy
```


Thank you very much