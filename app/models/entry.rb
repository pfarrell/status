class Entry < Sequel::Model
  many_to_one :group
end
