if Rails.env.test?
  ENV['API_TOKEN'] = '3471ab1e633c5a7585c3012da6be86202f7a9cec6114243981216b29be4b88ef5d9af757093c55f168fb4e9ff725a54941b1be77f0747fcb94bcede3565a9a4f'

  # Heroku: meurio-accounts-test
  ENV['ACCOUNTS_DATABASE'] = 'postgres://dnjclgjlscaafx:KWVXnJhiQcqLvrSOMja8PA-8xj@ec2-107-21-103-56.compute-1.amazonaws.com:5432/d2u64ljmm32d1d'
end
