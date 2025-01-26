class AbstrakteAbschlussarbeitsController < ApplicationController
  before_action :set_abstrakte_abschlussarbeit, only: %i[ show edit update destroy ]

  # GET /abstrakte_abschlussarbeits or /abstrakte_abschlussarbeits.json
  def index
    @abstrakte_abschlussarbeits = AbstrakteAbschlussarbeit.paginate(page: params[:page], per_page: 9)
  end

  # GET /abstrakte_abschlussarbeits/1 or /abstrakte_abschlussarbeits/1.json
  def show
    @abstrakte_abschlussarbeits = AbstrakteAbschlussarbeit.find(params[:id])
    @konkrete_abschlussarbeits = KonkreteAbschlussarbeit.where(projekt_id: @abstrakte_abschlussarbeit.projekt_id)
  end

  # GET /abstrakte_abschlussarbeits/new
  def new
    @abstrakte_abschlussarbeit = AbstrakteAbschlussarbeit.new
  end

  # GET /abstrakte_abschlussarbeits/1/edit
  def edit
  end

  # POST /abstrakte_abschlussarbeits or /abstrakte_abschlussarbeits.json
  def create
    @abstrakte_abschlussarbeit = AbstrakteAbschlussarbeit.new(abstrakte_abschlussarbeit_params)

    respond_to do |format|
      if @abstrakte_abschlussarbeit.save
        format.html { redirect_to @abstrakte_abschlussarbeit, notice: "Abstrakte abschlussarbeit was successfully created." }
        format.json { render :show, status: :created, location: @abstrakte_abschlussarbeit }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @abstrakte_abschlussarbeit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /abstrakte_abschlussarbeits/1 or /abstrakte_abschlussarbeits/1.json
  def update
    respond_to do |format|
      if @abstrakte_abschlussarbeit.update(abstrakte_abschlussarbeit_params)
        format.html { redirect_to @abstrakte_abschlussarbeit, notice: "Abstrakte abschlussarbeit was successfully updated." }
        format.json { render :show, status: :ok, location: @abstrakte_abschlussarbeit }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @abstrakte_abschlussarbeit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /abstrakte_abschlussarbeits/1 or /abstrakte_abschlussarbeits/1.json
  def destroy
    @abstrakte_abschlussarbeit.destroy!

    respond_to do |format|
      format.html { redirect_to abstrakte_abschlussarbeits_path, status: :see_other, notice: "Abstrakte abschlussarbeit was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_abstrakte_abschlussarbeit
      @abstrakte_abschlussarbeit = AbstrakteAbschlussarbeit.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def abstrakte_abschlussarbeit_params
      params.expect(abstrakte_abschlussarbeit: [ :betreuer, :forschungsprojekt, :semester, :thema, :themenskizze, :projekt_id ])
    end
end
