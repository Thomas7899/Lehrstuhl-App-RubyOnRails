# app/controllers/api/klausuren_controller.rb
module Api
  class KlausurenController < Api::BaseController
    def index
      @klausuren = Klausur.all.order(:semester, :titel)
      render json: @klausuren
    end
  end
end