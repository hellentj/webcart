module ColoursHelper
  def colour_list
  	Colour.all.map{|p|[ p.colour, p.id ]}
  end
end
