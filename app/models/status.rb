class Status < Sequel::Model
  many_to_one :group
end
