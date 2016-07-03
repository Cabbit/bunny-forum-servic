FROM ruby:2.3.1
MAINTAINER david.roy@cabbit.co.uk

ENV REFRESHED_AT 2016-07-02

# Update repo
RUN apt-get -y update

# Copy the Gemfile and Gemfile.lock into the image.
# Temporarily set the working directory to where they are.
WORKDIR /tmp
ADD ./Gemfile Gemfile
ADD ./Gemfile.lock Gemfile.lock
RUN bundle install

RUN mkdir -p /var/www/bunny

# Copy the app code
COPY . /var/www/bunny

# Change workdir
WORKDIR /var/www/bunny

# Expose port 5000
EXPOSE 5000

# Gem setup
RUN gem install foreman

# Run goliath in production mode
CMD ["/bin/bash","-c", "bundle exec foreman start"]
