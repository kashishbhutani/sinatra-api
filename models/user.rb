class User < ActiveRecord::Base

    #Validations
    validates :name, presence: true, length: { minimum: 3, maximum: 255 }
    validates :mobile, presence: true, length: { maximum: 10 }
    validates :email, presence: true

    #Associations
    has_many :posts

end