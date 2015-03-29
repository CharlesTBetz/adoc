#!/bin/bash

apt-get -y update

# ruby prereqs
apt-get -y install git-core curl zlib1g-dev build-essential libssl-dev \
    libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev \
    libcurl4-openssl-dev python-software-properties libffi-dev



#su vagrant << EOF
    su vagrant << EOF
        export RBENV_ROOT="/home/vagrant/.rbenv"
        curl https://raw.githubusercontent.com/fesplugas/rbenv-installer/master/bin/rbenv-installer | bash
        
        echo '#!/bin/bash' >> .bash_profile
        echo 'export RBENV_ROOT="${HOME}/.rbenv"' >> .bash_profile
        echo 'if [ -d "${RBENV_ROOT}" ]; then'  >> .bash_profile
        echo    'export PATH="${RBENV_ROOT}/bin:${PATH}"'  >> .bash_profile
        echo    'eval "$(rbenv init -)"'  >> .bash_profile
        echo 'fi' >> .bash_profile
        
        export PATH="${RBENV_ROOT}/bin:${PATH}"
        env >> currEnv.txt
        rbenv install 2.2.1
        rbenv global 2.2.1
    EOF
#EOF



gem install bundler

su vagrant << EOF
   cd /vagrant
   bundle install   # see Gemfile
EOF
