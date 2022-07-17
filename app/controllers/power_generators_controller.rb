class PowerGeneratorsController < ApplicationController
  def index
    @power_generators = ((((PowerGenerator.order(price: :asc)).order(name: :asc)).order(kwp: :asc)).page params[:page]).per(6)
  end

  def search
    @simple_search = params[:query]
    if params[:query].present?
      @simple_search = @simple_search.downcase
      @power_generators = simple_query
      return render '/power_generators/search'
    end
    if @simple_search.nil?
      @advanced_search = params
      if @advanced_search.present?
         binding.pry
        @power_generators = advanced_query
        return render '/power_generators/search'
      end
    else
      redirect_to root_path
    end
    
  end

  private

  def simple_query
    PowerGenerator.where("lower(name) LIKE '%#{ @simple_search}%' OR lower(description) LIKE '%#{ @simple_search}%' OR lower(manufacturer) LIKE '%#{ @simple_search}%'")
  end


  def advanced_query
    @structure = @advanced_search[:structure_type]

    if @advanced_search[:structure_type].present? && @advanced_search[:name].empty? && @advanced_search[:manufacturer].empty?
      query = PowerGenerator.where(structure_type: @structure)
    end

    if @advanced_search[:structure_type].present? && @advanced_search[:structure_type] == "metalico"
      query = PowerGenerator.where("#{add_to_advanced_query}").metalico

    elsif @advanced_search[:structure_type].present? && @advanced_search[:structure_type] == "ceramico"
      query = PowerGenerator.where("#{add_to_advanced_query}").ceramico

    elsif @advanced_search[:structure_type].present? && @advanced_search[:structure_type] == "fibrocimento"
      query= PowerGenerator.where("#{add_to_advanced_query}").fibrocimento

    elsif @advanced_search[:structure_type].present? && @advanced_search[:structure_type] == "laje"
      query = PowerGenerator.where("#{add_to_advanced_query}").laje

    elsif @advanced_search[:structure_type].present? && @advanced_search[:structure_type] == "solo"
      query =PowerGenerator.where("#{add_to_advanced_query}").solo

    elsif @advanced_search[:structure_type].present? && @advanced_search[:structure_type] == "trapezoidal"
      query = PowerGenerator.where("#{add_to_advanced_query}").trapezoidal
    end

    if @advanced_search[:structure_type].present? == false
      query = PowerGenerator.where("#{add_to_advanced_query}")
    end
    query
  end
  

  def add_to_advanced_query
    @structure = @advanced_search[:structure_type]
    conditions = []
    if @advanced_search[:name].present?
      conditions << "name LIKE '%#{@advanced_search[:name]}%'"
      if @advanced_search[:manufacturer].present? 
        conditions << "manufacturer LIKE '%#{@advanced_search[:manufacturer]}%'"
      end
    end
    if @advanced_search[:manufacturer].present? && @advanced_search[:name].empty?
      conditions << "manufacturer LIKE '%#{@advanced_search[:manufacturer]}%'"
    end
    conditions.join(' AND ')
  end

  def alternative_query
    <<-QUERY
    #{advanced_where_conditionals}
    QUERY
  end

  def advanced_where_conditionals
    conditionals = []
    if @advanced_search[:name].present?
      conditionals << "name LIKE '%#{@advanced_search[:name]}%'"
    end
    conditionals.join(' AND ')
  end

end
