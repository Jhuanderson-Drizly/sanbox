require 'sequel'
require 'faker'
require 'mysql2'
con = Mysql2::Client.new(:host => "drizly-db", :username => "root", :db => 'drizly')

dbs = con.query('SHOW TABLES;')
dbs.each do |db|
  puts db
end

# puts(fake_full_address)
# puts fake_address
# puts fake_city
# puts fake_state
# puts fake_zip


orders_query_prev = con.query("SELECT billing_address FROM orders order by id limit 5").each do |row|
  puts(row['billing_address'])
end

puts 'updating'
orders_query = con.query("SELECT id FROM orders order by id limit 100").each do |row|
  id = row['id'].to_s
  fake_full_address = Faker::Address.full_address
  fake_address = fake_full_address.split(',')[0]
  # fake_city = fake_full_address.split(',')[1].strip()
  # fake_state = fake_full_address.split(',')[2].split(' ')[0].strip()
  # fake_zip = fake_full_address.split(',')[2].split(' ')[1]
  begin
    con.query("UPDATE orders SET billing_address = '" + fake_address + "' where id =" + id)
  rescue
    next
  end
end

orders_query_after = con.query("SELECT billing_address FROM orders order by id limit 5").each do |row|
  puts(row['billing_address'])
end
con.close

