class Entry < Sequel::Model
  many_to_one :group
  one_to_many :statuses
end
