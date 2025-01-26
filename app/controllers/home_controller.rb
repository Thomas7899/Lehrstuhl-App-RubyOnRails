class HomeController < ApplicationController
  allow_unauthenticated_access
  def index
  end

  def search
    if params[:vorname_search].present?
      @students = Student.where("vorname ILIKE ?", "%#{params[:vorname_search]}%")
    else
      @students = [] # Or any other behavior you want when the search term is empty
    end
  
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update("search_results", partial: "students/search_results", locals: { students: @students })
      end
    end
  end
end
