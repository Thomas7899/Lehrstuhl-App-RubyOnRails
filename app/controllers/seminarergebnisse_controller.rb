class SeminarergebnisseController < ApplicationController
  # GET /seminarergebnisse
  def index
    @seminarergebnisse = Seminarergebnis.includes(:student, :seminar).all
  end
end