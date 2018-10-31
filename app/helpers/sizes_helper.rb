module SizesHelper
  def size_list
  	Size.all.map{|p|[ p.size, p.id ]}
  end
end
