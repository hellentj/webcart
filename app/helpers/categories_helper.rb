module CategoriesHelper
  def category_list
    Category.all.map{|p|[ p.category_name, p.id ]}
  end
end
