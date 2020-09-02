class Post < ActiveRecord::Base

    #Validations
    validates :title, presence: true, length: { minimum: 5, maximum: 255 }
    validates :description, presence: true

end