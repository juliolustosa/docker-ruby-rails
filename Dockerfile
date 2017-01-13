# Base image:
FROM ruby:2.3

# Install dependencies
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

# Set an environment variable where the Rails app is installed to inside of Docker image:
ENV APP_HOME /app
RUN mkdir -p $APP_HOME

# Set working directory, where the commands will be ran:
WORKDIR $APP_HOME

# Copy scripts
COPY scripts/auto-bundle-install.lib /
COPY scripts/auto-bundle-install.sh /
COPY scripts/auto-schema.sh /
COPY scripts/start-puma.sh /
COPY scripts/init.sh /

RUN chmod +x /auto-bundle-install.sh
RUN chmod +x /auto-schema.sh
RUN chmod +x /start-puma.sh
RUN chmod +x /init.sh

EXPOSE 3000
EXPOSE 1025

CMD ["/bin/bash", "/init.sh"]
