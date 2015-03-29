#!/bin/bash

# direct Ruby build - no environment manager

apt-get -y update

# ruby prereqs
apt-get -y install git-core curl zlib1g-dev build-essential libssl-dev \
    libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev \
    libcurl4-openssl-dev python-software-properties libffi-dev

# legacy asciidoc for now
apt-get -y install asciidoc fop #prefer the a2x pdf build

# latest ruby is a prereq
wget http://cache.ruby-lang.org/pub/ruby/2.2/ruby-2.2.1.tar.gz
tar -xvf ruby-2.2.1.tar.gz
cd ruby-2.2.1
./configure
make
sudo make install

gem install bundler

su vagrant << EOF
   cd /vagrant
   bundle install   # see Gemfile
   ./render.sh   # initial render on vagrant up to test
EOF
