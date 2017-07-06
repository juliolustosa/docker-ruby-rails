FROM juliolustosa/ruby-rbenv:latest
MAINTAINER Julio Lustosa "contato@juliolustosa.com.br"

# Set an environment variable
ENV ENABLE_AUTO_GEMFILE true
ENV ENABLE_AUTO_MIGRATE true
ENV SSH_KNOW_HOSTS "github.com bitbucket.org"
ENV SSH_PRIVATE_KEY ""

# Common environment variables for framework configuration
ENV RACK_ENV production
ENV RAILS_ENV production
ENV APP_ENV production
ENV RAILS_SERVE_STATIC_FILES true
ENV RAILS_LOG_TO_STDOUT true
ENV SECRET_KEY_BASE $(openssl rand -base64 32)
ENV PORT 8080

USER root

# Install ssh client
RUN apt-get install openssh-client -y

# Copy Scripts
RUN mkdir -p /scripts
COPY ./init-scripts /scripts
RUN chown $USER:$USER /scripts
RUN chmod +x /scripts/*.sh

# Clear apt-get
RUN apt-get -qq clean autoclean

USER $USER

EXPOSE $PORT

CMD ["bash", "/scripts/init.sh"]