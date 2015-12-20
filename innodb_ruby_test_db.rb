require "innodb/record_describer"

class InnodbRubyTest_users_PRIMARY < Innodb::RecordDescriber
  type :clustered
  key 'id', 'int(11)', :NOT_NULL
  row 'firstname', 'varchar(255)', :NOT_NULL
  row 'lastname', 'varchar(255)', :NOT_NULL
  row 'phonenumber', 'varchar(255)', :NOT_NULL
  row 'state', 'varchar(255)'
  row 'companyname', 'varchar(255)'
  row 'created_at', :DATETIME, :NOT_NULL
  row 'updated_at', :DATETIME, :NOT_NULL
end

class InnodbRubyTest_users_state < Innodb::RecordDescriber
  type :secondary
  key 'state', 'varchar(255)'
  row 'id', 'int(11)', :NOT_NULL
  row 'companyname', 'varchar(255)'
end
