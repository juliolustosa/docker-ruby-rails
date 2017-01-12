[![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=E3G6KRHXDUF98&lc=US&item_name=Help%20Developer%20Julio%20Lustosa&currency_code=USD&bn=PP%2dDonationsBF%3abtn_donateCC_LG%2egif%3aNonHosted)

# Docker for Ruby on Rails with Auto Bundle Install
```shell
docker pull juliolustosa/ruby-rails
```

### 1 - Example docker-compose.yaml
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
      - "3000:3000"
    depends_on:
      - db
```
