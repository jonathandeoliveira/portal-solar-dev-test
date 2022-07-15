class PowerGeneratorsController < ApplicationController
  def index
    @power_generators = ((((PowerGenerator.order(price: :asc)).order(name: :asc)).order(kwp: :asc)).page params[:page]).per(6)
  end
end
