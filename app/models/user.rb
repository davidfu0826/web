class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable, :registrable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable
  include PasswordHelper

  before_validation(on: :create) do
    this_password = secure_password
    self.password = this_password
    self.password_confirmation = this_password
  end
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  after_create do
    #self.send_reset_password_instructions #TODO: Activate this, jag kommer glömma att starta mailcatcher
  end

  has_and_belongs_to_many :pages
  has_many :contact_forms, dependent: :destroy

  dragonfly_accessor :profile_image
  validates_property :format, of: :image, in: [:jpeg, :jpg, :png, :bmp], case_sensitive: false,
                   message: I18n.t('errors.messages.image_format'), if: :image_changed?

  translates :title

  enum role: %i{admin editor events}
  enum locale: %i{sv en}
end
