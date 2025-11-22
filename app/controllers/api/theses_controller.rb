# app/controllers/api/theses_controller.rb
module Api
  class ThesesController < Api::BaseController
    def index
      # Konkrete Abschlussarbeiten laden
      konkrete_arbeiten = KonkreteAbschlussarbeit.includes(:student).order(created_at: :desc)

      # Abstrakte Abschlussarbeiten laden
      abstrakte_arbeiten = AbstrakteAbschlussarbeit.order(created_at: :desc)

      # Statistiken berechnen
      konkrete_stats = {
        laufendeArbeiten: konkrete_arbeiten.count,
        diesenMonat: konkrete_arbeiten.where('created_at > ?', 1.month.ago).count,
        aktiveStudierende: konkrete_arbeiten.distinct.count(:student_id)
      }

      abstrakte_stats = {
        verfuegbareThemen: abstrakte_arbeiten.count,
        neueThemen: abstrakte_arbeiten.where('created_at > ?', 1.month.ago).count,
        kategorien: abstrakte_arbeiten.distinct.count(:forschungsprojekt)
      }

      # JSON-Antwort rendern
      render json: {
        konkrete: { items: konkrete_arbeiten.as_json(include: { student: { only: [:vorname, :nachname] } }), stats: konkrete_stats },
        abstrakte: { items: abstrakte_arbeiten.as_json, stats: abstrakte_stats }
      }
    end
  end
end