class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :email, length: { maximum: 255}
  validates :profile, length: { maximum: 200 } #追記
  validates :username, presence: true,length: { maximum: 50 }
end
