class AdvancedQuery

  def self.call(params)
    @params = params
    PowerGenerator.where(query).order(price: :asc).order(name: :asc).order(kwp: :asc)
  end

  private

  def self.query
    query = []
    
    if @params[:name].present?
      query << "lower(name) LIKE '%#{@params[:name].downcase}%'"
    end

    if @params[:manufacturer].present? 
      query << "lower(manufacturer) LIKE '%#{@params[:manufacturer].downcase}%'"
    end

   if @params[:structure_type].present?
     query << "structure_type = #{@params[:structure_type]}"
   end
    query.join(' AND ')
  end
end