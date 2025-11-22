class MitarbeiterController < ApplicationController
  # GET /mitarbeiter
  def index
    # Lädt alle Mitarbeiter und sortiert sie nach Nachname und Vorname
    @mitarbeiter = Mitarbeiter.order(:nachname, :vorname).all
  end

  # Hier könnten später weitere Aktionen wie show, new, create, etc. folgen.
end