class Group < Sequel::Model
  one_to_many :statuses

  def pivot
    h = Hash.new{|h,k| h[k] = []}
    self.statuses.each do |status|
      status.value.each do |k,v| 
        h[k] << v
      end
    end
    h
  end
end
