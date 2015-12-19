require 'mysql2'
require 'faker'
require 'i18n'

I18n.locale = :ja
require 'faker'
## need if using email address
## ref. http://qiita.com/kyanny/items/00ef3727c7738f2cc26c
# Faker::Config.locale = :en

task default: [:create_database]

desc 'create database innodb_ruby_test'
task :create_database do
  @db_host = 'localhost'
  @db_user = 'root'
  @db_pass = ''
  @db_name = 'innodb_ruby_test'
  @db_table = 'users'

  client = Mysql2::Client.new(host: @db_host, username: @db_user, password: @db_pass)
  client.query("DROP DATABASE IF EXISTS #{@db_name}")
  client.query("CREATE DATABASE #{@db_name}")
  client.query("USE #{@db_name}")
  client.query("DROP TABLE IF EXISTS #{@db_table}")
  client.query <<-"SQL"
    CREATE TABLE #{@db_table} (
      `id` int(11) NOT NULL AUTO_INCREMENT,
      `firstname` varchar(255) COLLATE utf8_general_ci NOT NULL,
      `lastname` varchar(255) COLLATE utf8_general_ci NOT NULL,
      `phonenumber` varchar(255) COLLATE utf8_general_ci NOT NULL,
      `state` varchar(255) COLLATE utf8_general_ci DEFAULT NULL,
      `city` varchar(255) COLLATE utf8_general_ci DEFAULT NULL,
      `companyname` varchar(255) COLLATE utf8_general_ci DEFAULT NULL,
      `created_at` datetime NOT NULL,
      `updated_at` datetime NOT NULL,
      PRIMARY KEY (`id`)
    ) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
  SQL

  # TODO bulk insert
  100000.times do
    firstname = Faker::Name::first_name
    lastname = Faker::Name::last_name
    phonenumber = Faker::PhoneNumber.phone_number
    state = Faker::Address.state
    city = Faker::Address.city
    companyname = Faker::Company.name
    now = Time.now.strftime "%F %T"

    statement = client.prepare <<-"SQL"
      INSERT INTO #{@db_table}
        (firstname, lastname, phonenumber, state, city, companyname, created_at, updated_at)
      VALUES
        (?, ?, ?, ?, ?, ?, ?, ?)
    SQL
    statement.execute(firstname, lastname, phonenumber, state, city, companyname, now, now)
  end
  client.close
end
