class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable, :registrable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  has_one :page

  translates :title

  enum role: %i{admin editor events}
  enum locale: %i{sv en}
end
