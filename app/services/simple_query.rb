class SimpleQuery
  def self.call(params)
    @params = params
    PowerGenerator.where(query).order(price: :asc).order(name: :asc).order(kwp: :asc)
  end

  private

  def self.query
    <<-QUERY
      lower(name) LIKE '%#{@params.downcase}%'
      OR lower(description) LIKE '%#{@params.downcase}%'
      OR lower(manufacturer) LIKE '%#{@params.downcase}%'
    QUERY
  end
end