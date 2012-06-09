server folder to server machine.

tsung folder to client machine

Is mandatory to export ssh keys to all machines and to have resolved its names in /etc/hosts

Added tsung-template.xml file to test all webserver technologies.

The Testbed has 4 machines. test1(could of one core it is launching the test), test2 & test3 (2 cores) and myserver (4 cores).

Each machine need to be accesible with ssh (export keys to atorized_keys for each machine, personally I have one machine).

/etc/hosts map each name of testbed with the real ip, and "ip add addr ..." is used to simulate more ips.

tsung and erlang must be of the same version foreach machine. 

Performance trick:
copy sysctl.conf to /etc/sysctl.conf to server and client machines. It decrease tcp_fin timeout and reuse of sockets 

Configuration trick:
copy rc.local to /etc/rc.local to configure virtual ips of test for each machine. Range configured from last digit of hostname

sudo apt-get install tsung
./tsungload test.cfg

pip install requirements.txt in your virtualenv

