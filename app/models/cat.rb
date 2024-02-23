class Cat < ApplicationRecord
  def self.ransackable_attributes(auth_object = nil)
    ["age", "created_at", "id", "name", "updated_at"]
  end
end
