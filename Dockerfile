FROM jenkins/jenkins:lts

USER root

RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
RUN \curl -sSL https://get.rvm.io | bash -s stable
RUN /bin/bash -l -c 'source /etc/profile.d/rvm.sh'
ENV PATH="$PATH:${HOME}/.rvm/bin"

# Install Ruby
RUN /bin/bash -l -c "rvm requirements"
RUN /bin/bash -l -c "rvm install ruby-2.6.5"
RUN /bin/bash -l -c "rvm use ruby-2.6.5 --default"
RUN /bin/bash -l -c "rvm rubygems current"

# Install bundler
RUN /bin/bash -l -c "gem install bundler -v 1.17.3 --no-doc"
