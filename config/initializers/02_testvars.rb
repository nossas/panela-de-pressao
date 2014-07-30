if Rails.env.test?
  ENV['API_TOKEN'] = '3471ab1e633c5a7585c3012da6be86202f7a9cec6114243981216b29be4b88ef5d9af757093c55f168fb4e9ff725a54941b1be77f0747fcb94bcede3565a9a4f'
  ENV['MEURIO_ACCOUNTS_URL'] = "http://127.0.0.1/meurio_accounts"
  ENV["CAS_SERVER_URL"] = "http://127.0.0.1/meurio_accounts"
  ENV['MEURIO_HOST'] = "http://www.meurio-dev.org.br"
  ENV['MEURIO_API_TOKEN'] = "123"
  ENV['POKE_TASK_TYPE_ID'] = "1"
  ENV["MEURIO_HOST"] = "http://www.meurio-dev.org.br"
  ENV["MEURIO_API_TOKEN"] = "123"
end
