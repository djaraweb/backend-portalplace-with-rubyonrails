class PropertiesSearchService
  def self.search(curr_properties, query)
    curr_properties.where("title like '%#{query}%'")
  end
end