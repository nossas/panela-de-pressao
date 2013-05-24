[![Build Status](https://secure.travis-ci.org/meurio/panela-de-pressao.png?branch=master)](http://travis-ci.org/meurio/panela-de-pressao)
[![Code Climate](https://codeclimate.com/github/meurio/panela-de-pressao.png)](https://codeclimate.com/github/meurio/panela-de-pressao)

# Getting Started
1. We suppose you already have Ruby on Rails and Git installed;
2. `git clone git://github.com/meurio/panela-de-pressao.git`
3. `cd panela-de-pressao`
4. `bundle install`
5. Copy `config/database.sample.yml` to `config/database.yml` and set your database;
6. `rake db:create`
7. `rake db:migrate`
8. `touch config/initializers/01_envvars.rb`
9. Open `config/initializers/01_envvars.rb` with you preferred editor and set some required environment variables (change their values to yours):
`ENV["FB_ID"] = "fb id"`
`ENV["FB_SECRET"] = "fb secret"`
`ENV["AWS_ID"] = "aws id"`
`ENV["AWS_SECRET"] = "aws secret"`
`ENV["TWITTER_ID"] = "twitter id"`
`ENV["TWITTER_SECRET"] = "twitter secret"`
`ENV["BITLY_ID"] = "bit.ly id"`
`ENV["BITLY_SECRET"] = "bit.ly secret"`
10. `rails s`
11. Now try [http://localhost:3000/](http://localhost:3000/)

Need help? Create an [issue](https://github.com/meurio/panela-de-pressao/issues) and we help you.


