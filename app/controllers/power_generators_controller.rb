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
    @best_freight = check_best  
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
  @power_generator = PowerGenerator.find(params[:power_generator_id])
  @state = CheckCep.check_api(params[:cep])
  if @state == 400
    return redirect_to @power_generator, notice: 'Erro! Cep inválido' 
  end
  if @power_generator.weight <= @power_generator.cubic_weight && @state != 400
    @best_freight = Freight.find_by("state LIKE '%#{@state}%' AND weight_min <= '#{@power_generator.weight}' AND weight_max >= '#{@power_generator.weight}'")
    return @best_freight.cost
  elsif @power_generator.weight >= @power_generator.cubic_weight && @state != 400
    @best_freight = Freight.find_by("state LIKE '%#{@state}%' AND weight_min <= '#{@power_generator.cubic_weight}' AND weight_max >= '#{@power_generator.cubic_weight}'")
    return @best_freight.cost.truncate(2)
  else
    redirect_to @power_generator, notice: 'Erro! Não foi possível calcular o frete'
  end
end