class CompanyValue < ApplicationRecord
    validates :title, presence: true, uniqueness: true

    def created_at
        attributes['created_at'].strftime("%d/%m/%Y %H:%M")
    end

    def updated_at
        attributes['updated_at'].strftime("%d/%m/%Y %H:%M")
    end

end
