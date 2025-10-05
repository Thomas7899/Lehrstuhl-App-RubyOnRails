class StudentsController < ApplicationController
  before_action :set_student, only: %i[ show edit update destroy ]

  # Entfernte separate search Action: Suche jetzt integriert in index

  # GET /students or /students.json
  def index
    # Per-page Parameter aus URL oder Standard verwenden
    per_page = params[:per_page]&.to_i || 9
    # Sicherheitsbegrenzung für per_page
    per_page = [per_page, 100].min if per_page > 0
    per_page = 9 if per_page <= 0
    
    # Basis-Query
    students = Student.all
    
    # Suchfunktionalität
    if params[:search_query].present?
      query = params[:search_query]
      students = students.where(
        "vorname ILIKE :query OR nachname ILIKE :query OR matrikelnummer ILIKE :query OR email ILIKE :query",
        query: "%#{query}%"
      )
    end
    
    # Sortierung
    case params[:sort]
    when 'name_asc'
      students = students.order(:vorname, :nachname)
    when 'name_desc'
      students = students.order(vorname: :desc, nachname: :desc)
    when 'matrikel'
      students = students.order(:matrikelnummer)
    else
      students = students.order(:created_at)
    end
    
    @students = students.paginate(page: params[:page], per_page: per_page)
    
    # Einfache HTML Antwort (alle Parameter via GET in Links erhalten)
    respond_to do |format|
      format.html
    end
  end

  # GET /students/1 or /students/1.json
  def show
    @student = Student.find(params[:id])
    #@konkrete_abschlussarbeit = @student.konkrete_abschlussarbeit
    if @student.konkrete_abschlussarbeit
      @konkrete_abschlussarbeit = KonkreteAbschlussarbeit.find_by(matrikelnummer: @student.konkrete_abschlussarbeit.matrikelnummer)
    else
      @konkrete_abschlussarbeit = nil
    end
  end

  # GET /students/new
  def new
    @student = Student.new
  end

  # GET /students/1/edit
  def edit
  end

  # POST /students or /students.json
  def create
    @student = Student.new(student_params)

    respond_to do |format|
      if @student.save
        format.html { redirect_to @student, notice: "Student was successfully created." }
        format.json { render :show, status: :created, location: @student }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /students/1 or /students/1.json
  def update
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to @student, notice: "Student was successfully updated." }
        format.json { render :show, status: :ok, location: @student }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1 or /students/1.json
  def destroy
    @student.destroy!

    respond_to do |format|
      format.html { redirect_to students_path, status: :see_other, notice: "Student was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def student_params
      params.require(:student).permit(:email, :matrikelnummer, :vorname, :nachname, :geburtsdatum)
    end
end
