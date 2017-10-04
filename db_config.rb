require 'active_record'

options = {
  adapter: 'postgresql',
  database: 'pawsclaws_db'
}
ActiveRecord::Base.establish_connection(options)
