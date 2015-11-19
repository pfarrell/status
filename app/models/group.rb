class Group < Sequel::Model
  one_to_many :entries

  def pivot
    require 'byebug'
    h = Hash.new{|h,k| h[k] = []}
    self.entries.each do |entry| 
      entry.statuses.each do |status|
        status.value.each do |k,v| 
          h[k] << v
        end
      end
    end
    h
  end
end
