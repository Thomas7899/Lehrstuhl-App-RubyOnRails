class KonkreteAbschlussarbeitsController < ApplicationController
  before_action :set_konkrete_abschlussarbeit, only: %i[ show edit update destroy ]

  # GET /konkrete_abschlussarbeits or /konkrete_abschlussarbeits.json
  def index
    @konkrete_abschlussarbeits = KonkreteAbschlussarbeit.paginate(page: params[:page], per_page: 9)
  end

  # GET /konkrete_abschlussarbeits/1 or /konkrete_abschlussarbeits/1.json
  def show
  end

  # GET /konkrete_abschlussarbeits/new
  def new
    @konkrete_abschlussarbeit = KonkreteAbschlussarbeit.new
  end

  # GET /konkrete_abschlussarbeits/1/edit
  def edit
  end

  # POST /konkrete_abschlussarbeits or /konkrete_abschlussarbeits.json
  def create
    @konkrete_abschlussarbeit = KonkreteAbschlussarbeit.new(konkrete_abschlussarbeit_params)

    respond_to do |format|
      if @konkrete_abschlussarbeit.save
        format.html { redirect_to @konkrete_abschlussarbeit, notice: "Konkrete abschlussarbeit was successfully created." }
        format.json { render :show, status: :created, location: @konkrete_abschlussarbeit }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @konkrete_abschlussarbeit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /konkrete_abschlussarbeits/1 or /konkrete_abschlussarbeits/1.json
  def update
    respond_to do |format|
      if @konkrete_abschlussarbeit.update(konkrete_abschlussarbeit_params)
        format.html { redirect_to @konkrete_abschlussarbeit, notice: "Konkrete abschlussarbeit was successfully updated." }
        format.json { render :show, status: :ok, location: @konkrete_abschlussarbeit }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @konkrete_abschlussarbeit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /konkrete_abschlussarbeits/1 or /konkrete_abschlussarbeits/1.json
  def destroy
    @konkrete_abschlussarbeit.destroy!

    respond_to do |format|
      format.html { redirect_to konkrete_abschlussarbeits_path, status: :see_other, notice: "Konkrete abschlussarbeit was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_konkrete_abschlussarbeit
      @konkrete_abschlussarbeit = KonkreteAbschlussarbeit.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def konkrete_abschlussarbeit_params
      params.expect(konkrete_abschlussarbeit: [ :betreuer, :forschungsprojekt, :semester, :matrikelnummer, :angepasste_themenskizze, :gesetzte_schwerpunkte, :anmeldung_pruefungsamt, :abgabedatum, :studienniveau, :student_id ])
    end
end
