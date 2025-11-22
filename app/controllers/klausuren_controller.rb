class KlausurenController < ApplicationController
  # GET /klausuren
  def index
    @klausuren = Klausur.order(:semester, :titel).all
  end
end