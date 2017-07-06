[![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=E3G6KRHXDUF98&lc=US&item_name=Help%20Developer%20Julio%20Lustosa&currency_code=USD&bn=PP%2dDonationsBF%3abtn_donateCC_LG%2egif%3aNonHosted)

# Docker base image for Ruby with Rbenv
```shell
docker pull juliolustosa/ruby-rbenv
```

### What's included?

* Ubuntu 16.04 LTS as base system.
* Unattended Security Upgrades
* Rbenv
* Ruby versions 2.4.1 and 2.3.4
* Ruby version default is 2.3.4
* Node.js
* RPM
* Yarn
* SSH Client
* Auto Gemfile Install (env ENABLE_AUTO_GEMFILE)
* Auto Migrate Install (env ENABLE_AUTO_MIGRATE)
* SSH Private Key Install (env SSH_PRIVATE_KEY)

### The `deploy` user

The image has an `deploy` user with UID 9999 and home directory `/home/deploy`. Your application is supposed to run as this user. Even though Docker itself provides some isolation from the host OS, running applications without root privileges is good security practice.

Your application should be placed inside `/app`

### Example docker-compose.yaml
```yml
# docker-compose.yaml
version: '2'
services:
  db:
    image: postgres:9.5
    ports:
      - "5432:5432"
    environment:
      POSTGRES_USER: DATABASE_USERNAME
      POSTGRES_PASSWORD: DATABASE_PASSWORD
  web:
    image: juliolustosa/ruby-rails
    volumes:
      - .:/app
    ports:
      - "8080:8080"
    depends_on:
      - db
```

## Donation
If this project help you reduce time to develop, you can give me a cup of coffee :)

[![paypal](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=E3G6KRHXDUF98&lc=US&item_name=Help%20Developer%20Julio%20Lustosa&currency_code=USD&bn=PP%2dDonationsBF%3abtn_donateCC_LG%2egif%3aNonHosted)
