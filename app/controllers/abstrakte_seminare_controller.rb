class AbstrakteSeminareController < ApplicationController
  # GET /abstrakte-seminare
  def index
    @abstrakte_seminare = AbstraktesSeminar.order(:thema).all
  end
end