# Teknologkåren LTH

This is the repository containing the code for the Rails application acting as a CMS system for teknologkåren at LTH

## Setup

The site uses a number of technologies, the most important among them being rails.



JS/coffee

Gems/S3/JS Libraries

Caching

SASS

Procfile

Developing

Important files and config

## Development setup

### Pre-Install
0. Use Linux/OSX, trying to install ruby and rails on windows is an exercise in futility
0. Install the development requirements
0. Install Ruby

### Setup

0. run `bundle install` to download and install gems
0. run `rake db:setup` to setup a database with columns


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
