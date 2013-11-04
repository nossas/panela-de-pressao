# encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
#   Transporte público
[
  "Indústria, Comércio e Emprego",
  "Ciência e Tecnologia",
  "Direitos Humanos",
  "Educação",
  "Esportes, Lazer e Cultura",
  "Orçamento e Fiscalização Financeira",
  "Saúde e Drogas",
  "Crianças e adolescentes",
  "Pessoas de terceira idade",
  "Meio Ambiente e Direitos dos Animais",
  "Defesa do Consumidor",
  "Obras Públicas e Infraestrutura",
  "Transportes e Trânsito",
  "Turismo"
].each do |category|
  Category.create :name => category
end
