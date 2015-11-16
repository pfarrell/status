class Status < Sequel::Model
  many_to_one :entry
end
