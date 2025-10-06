class Student < ApplicationRecord
    has_one :konkrete_abschlussarbeit, dependent: :destroy
    has_many :sessions, foreign_key: "user_id", dependent: :destroy
    has_many :chat_messages, foreign_key: "user_id", dependent: :destroy

  validates :vorname, presence: true
  validates :nachname, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :matrikelnummer, presence: true, uniqueness: true
  validates :geburtsdatum, presence: true


    def self.search(query)
        where(
          "vorname ILIKE :query OR nachname ILIKE :query OR matrikelnummer ILIKE :query OR email ILIKE :query",
          query: "%#{query}%"
        )
      end

        def full_name
    "#{vorname} #{nachname}"
  end

  def display_name
    full_name
  end
end
