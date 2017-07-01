FROM ubuntu:latest

RUN apt-get -y update \
    && apt-get -y --no-install-recommends install \
    ruby ruby-dev postgresql curl zlib1g-dev ca-certificates build-essential libpq-dev \
    libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 \
    libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties \
    libffi-dev nodejs libgdbm-dev libncurses5-dev automake libtool bison libffi-dev \
    && gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 \
    && curl -sSL https://get.rvm.io | bash -s stable \
    && /bin/bash -c "source /etc/profile.d/rvm.sh \
       && rvm install 2.4.0 \
       && rvm use 2.4.0 --default" \
    && gem install bundler rails

WORKDIR /src
ADD . .

# init postgres
USER postgres
RUN /etc/init.d/postgresql start \
    && psql -c "create user root with superuser;" \
    && createdb -O root root

# init application
EXPOSE 3000
USER root
RUN /etc/init.d/postgresql start \
    && bundle install \
    && rake db:create \
    && rake db:migrate \
    && rake db:seed

CMD ["/etc/init.d/postgresql", "start", "&&", "bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
