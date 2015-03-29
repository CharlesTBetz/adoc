#!/bin/bash

# attempting build of rbenv

apt-get -y update

# ruby prereqs
apt-get -y install git-core curl zlib1g-dev build-essential libssl-dev \
    libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev \
    libcurl4-openssl-dev python-software-properties libffi-dev 

gem install bundler


# this is such a hack. but ~ resolves to /root with vagrant.
# tried su << EOF but strange behavior with variable interpolation.
export VAGRANT_USER_HOME="/home/vagrant"

git clone git://github.com/sstephenson/rbenv.git $VAGRANT_USER_HOME/.rbenv
echo '#!/bin/bash' >> .bash_profile
echo 'export RBENV_ROOT="~/.rbenv"' >> $VAGRANT_USER_HOME/.bash_profile
echo 'export PATH="~/.rbenv/bin:$PATH"' >> $VAGRANT_USER_HOME/.bash_profile
echo 'eval "$(rbenv init -)"' >> $VAGRANT_USER_HOME/.bash_profile

git clone git://github.com/sstephenson/ruby-build.git $VAGRANT_USER_HOME/.rbenv/plugins/ruby-build
echo 'export PATH="~/.rbenv/plugins/ruby-build/bin:$PATH"' >> $VAGRANT_USER_HOME/.bash_profile

git clone https://github.com/sstephenson/rbenv-gem-rehash.git $VAGRANT_USER_HOME/.rbenv/plugins/rbenv-gem-rehash

export RBENV_ROOT="$VAGRANT_USER_HOME/.rbenv"
export PATH="$VAGRANT_USER_HOME/.rbenv/bin:$VAGRANT_USER_HOME/.rbenv/plugins/ruby-build/bin:$PATH"

chown -R vagrant $VAGRANT_USER_HOME/.rbenv && chgrp -R vagrant $VAGRANT_USER_HOME/.rbenv

#env >> currEnv.txt

rbenv install 2.2.1
rbenv global 2.2.1

echo "gem: --no-ri --no-rdoc" > $VAGRANT_USER_HOME/.gemrc
    
su vagrant << EOF

    cd /vagrant
    bundle install   # see Gemfile

EOF
