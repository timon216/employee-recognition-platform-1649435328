class CompanyValue < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  has_many :kudos, class_name: "Kudo", dependent: :destroy

  def created_at
    attributes['created_at'].strftime('%d/%m/%Y %H:%M')
  end

  def updated_at
    attributes['updated_at'].strftime('%d/%m/%Y %H:%M')
  end
end
