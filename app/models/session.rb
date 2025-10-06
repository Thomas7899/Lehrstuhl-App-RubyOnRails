class Session < ApplicationRecord
  belongs_to :user, class_name: "Student"
end
