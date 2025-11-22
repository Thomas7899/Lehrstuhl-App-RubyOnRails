class KlausurergebnisseController < ApplicationController
  # GET /klausurergebnisse
  def index
    @klausurergebnisse = Klausurergebnis.includes(:student, :klausur).all
  end
end