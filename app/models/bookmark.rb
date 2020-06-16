class Bookmark < ApplicationRecord
  validates :url, format: { with: /\Ahttps?:\/\//, message: "http始まりであること" }
end
