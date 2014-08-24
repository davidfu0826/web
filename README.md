## Setup 

 1. Install Vargrant and VirtualBox.
 2. Follow Vagrant guide below.

### Vagrant
  
```
#!sh
  vagrant up
  vagrant ssh
  cd /vagrant
  bin/bundle install --without production
  bin/rake db:create db:migrate
  TRUSTED_IP=`netstat -rn | grep "^0.0.0.0 " | cut -d " " -f10` bin/rails s
```

The reasons for using rails s with **TRUSTED_IP** is to make sure better_errors is working as it should on the Vagrant machine.
If better_errors doesn't work try using: **TRUSTED_IP=0.0.0.0/0 rails s**
