class SimpleTestController < ApplicationController
  # Für Debug-Zwecke - CSRF komplett deaktivieren
  skip_before_action :verify_authenticity_token
  
  def test
    render json: { message: "Server funktioniert!", user: Current.user&.email || "Nicht eingeloggt" }
  end
end
