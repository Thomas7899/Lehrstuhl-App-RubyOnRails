class SearchController < ApplicationController
    def index
        query = params[:search_query].presence

        # Suche in den Studenten
        @students = query ? Student.search(query) : []

        # Suche in den konkreten Abschlussarbeiten
        @konkrete_abschlussarbeiten = query ? KonkreteAbschlussarbeit.search(query) : []

        # Suche in den abstrakten Abschlussarbeiten
        @abstrakte_abschlussarbeiten = query ? AbstrakteAbschlussarbeit.search(query) : []

        respond_to do |format|
          format.turbo_stream { render turbo_stream: turbo_stream.update("search_results", partial: "students/search_results") }
          format.html { render :index }
        end
      end
end
