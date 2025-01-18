class StudentsController < ApplicationController
  before_action :set_student, only: %i[ show edit update destroy ]


  def search
    if params[:vorname_search].present?
      @students = Student.where("vorname ILIKE ?", "%#{params[:vorname_search]}%")
    else
      @students = []
    end
  
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update("search_results", partial: "students/search_results", locals: { students: @students })
      end
    end
  end
  

  # GET /students or /students.json
  def index
    @students = Student.paginate(page: params[:page], per_page: 9)
  end

  # GET /students/1 or /students/1.json
  def show
    @student = Student.find(params[:id])
    @konkrete_abschlussarbeit = @student.konkrete_abschlussarbeit
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
      @student = Student.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def student_params
      params.expect(student: [ :email, :matrikelnummer, :vorname, :nachname, :geburtsdatum ])
    end
end
