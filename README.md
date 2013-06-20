vagrant-mvm-1
=============

These days we have projects involving multiple machines. We have our website code in one but database is in another machine. We also frequently use distributed worker-queue systems.

This is one of the (yet to come)many configured vagrant machines to make coding for such systems possible, locally.  

A Multi-VM environment requires a master and slave machines. This instance has 1 master and 2 slave VMs. They are assigned static IPs. 

The master machine has:

- [Beanstalk](http://kr.github.io/beanstalkd/) - a simple, fast work queue.
- [Supervisor](http://supervisord.org/) - a client/server system that allows its users to monitor and control a number of processes on UNIX-like operating systems.

The slave machine has:

- [Circus](http://circus.readthedocs.org/en/0.8.1/) - a system to monitor and control processes and sockets.

The master is also configured to have multiple interfaces and runs different instances of Beanstalk for each assigned IP. 

[![githalytics.com alpha](https://cruel-carlota.pagodabox.com/445f9c08b8e67fe45b005b41088b6b35 "githalytics.com")](http://githalytics.com/github.com/mmohiudd)