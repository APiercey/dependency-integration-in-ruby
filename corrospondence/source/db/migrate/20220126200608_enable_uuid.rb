class EnableUuid < ActiveRecord::Migration[7.0]
  def change
    execute 'CREATE EXTENSION pgcrypto WITH SCHEMA pg_catalog;'
  end
end
