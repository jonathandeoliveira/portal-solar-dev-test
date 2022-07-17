class PowerGeneratorsController < ApplicationController
  def index
    @power_generators = ((((PowerGenerator.order(price: :asc)).order(name: :asc)).order(kwp: :asc)).page params[:page]).per(6)
  end

  def show
    @power_generator = PowerGenerator.find(params[:id])
    @power_generator.cubic_weight_calculator
  end

  def check_freight
    @power_generator = PowerGenerator.find(params[:power_generator_id])
    @state = CheckCep.check_api(params[:cep])
    binding.pry
  end



  def search
    @simple_search = params[:query]
    if params[:query].present?
      @power_generators = SimpleQuery.call(@simple_search)
      return render '/power_generators/search'
    end
    if @simple_search.nil?
      @advanced_search = params
      if @advanced_search.present?
        @power_generators = AdvancedQuery.call(@advanced_search)
        return render '/power_generators/search'
      end
    else
      redirect_to root_path, notice: 'Campo de pesquisa em branco'
    end
  end
end

private 

def check_best
  @power = params
  binding.pry
  @power_generator = @power_generator
  if @power_generator.weight >= @power_generator.cubic_weight
    @best_freight = Freight.where("state LIKE '%#{@state}%' AND weight_min <= '#{@power_generator.weight}' AND weight_max >= '#{@power_generator.weight}'")
  end
  if @power_generator.weight <= @power_generator.cubic_weight
    @best_freight = Freight.where("state LIKE '%#{@state}%' AND weight_min <= '#{@power_generator.cubic_weight}' AND weight_max >= '#{@power_generator.cubic_weight}'")
  end

end