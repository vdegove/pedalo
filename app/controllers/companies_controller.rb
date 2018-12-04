class CompaniesController < ApplicationController

  def new
    @company = Company.new
    authorize @company
  end

  def create
  end
end
