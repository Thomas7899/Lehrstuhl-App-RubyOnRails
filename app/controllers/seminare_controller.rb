class SeminareController < ApplicationController
  before_action :set_seminar, only: %i[ show edit update destroy ]
  before_action :load_collections, only: %i[ new edit create update ]

  # GET /seminare
  def index
    @seminare = Seminar.includes(:mitarbeiter, :abstraktes_seminar).all
  end

  # GET /seminare/1
  def show
    # Eager load students for the seminar
    @seminar = Seminar.includes(seminarergebnisse: :student).find(params[:id])
  end

  # GET /seminare/new
  def new
    @seminar = Seminar.new
  end

  # GET /seminare/1/edit
  def edit
  end

  # POST /seminare
  def create
    @seminar = Seminar.new(seminar_params)

    if @seminar.save
      redirect_to @seminar, notice: "Seminar wurde erfolgreich erstellt."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /seminare/1
  def update
    if @seminar.update(seminar_params)
      redirect_to @seminar, notice: "Seminar wurde erfolgreich aktualisiert."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /seminare/1
  def destroy
    @seminar.destroy
    redirect_to seminare_url, notice: "Seminar wurde erfolgreich gelöscht."
  end

  private
    def set_seminar
      @seminar = Seminar.find(params[:id])
    end

    def load_collections
      @mitarbeiters = Mitarbeiter.all.order(:nachname, :vorname)
      @abstrakte_seminare = AbstraktesSeminar.all.order(:thema)
    end

    def seminar_params
      params.require(:seminar).permit(:titel, :aufnahmekapazitaet, :semester, :praesenzdatum, :ort, :mitarbeiter_id, :abstraktes_seminar_id)
    end
end