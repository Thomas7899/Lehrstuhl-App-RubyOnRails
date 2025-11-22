# app/controllers/api/seminare_controller.rb
module Api
  class SeminareController < Api::BaseController
    def index
      seminare = Seminar.includes(:mitarbeiter, :abstraktes_seminar).all

      render json: seminare.as_json(
        include: {
          mitarbeiter: { only: [:titel, :vorname, :nachname] },
          abstraktes_seminar: { only: [:thema] }
        },
        except: [:created_at, :updated_at]
      )
    end

    def show
      seminar = Seminar.includes(:mitarbeiter, :abstraktes_seminar).find(params[:id])

      render json: seminar.as_json(
        include: {
          mitarbeiter: { only: [:titel, :vorname, :nachname] },
          abstraktes_seminar: { only: [:thema] }
        },
        except: [:created_at, :updated_at]
      )
    end
  end
end
