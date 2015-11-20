class Group < Sequel::Model
  one_to_many :entries

  def pivot
    require 'byebug'
    h = Hash.new{|h,k| h[k] = Hash.new{|h,k| h[k] = []}}
    self.entries.each do |entry| 
      entry_key = h[entry.name]
      entry.statuses.each do |status|
        status.value.each do |k,v| 
          entry_key[k] << v
        end
      end
    end
    h
  end
end
