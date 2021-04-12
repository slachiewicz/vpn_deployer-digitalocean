FROM ruby:2.7.3
MAINTAINER Joseph D. Marhee <joseph@marhee.me>

ADD app.rb /root/app.rb
ADD Gemfile /root/Gemfile
ADD views/index.erb /root/views/index.erb
ADD views/confirmation.erb /root/views/confirmation.erb
ADD environment.rb /root/environment.rb
WORKDIR /root
RUN bundle install

ENTRYPOINT ["ruby","app.rb","-o","0.0.0.0"]
