# app/controllers/api/students_controller.rb
module Api
  class StudentsController < Api::BaseController
    def index
      @students = Student.all.order(:nachname, :vorname)
      render json: @students
    end
  end
end