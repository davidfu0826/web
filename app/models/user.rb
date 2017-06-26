class User < ApplicationRecord
  include PasswordHelper
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable, :registrable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable,
         :validatable

  before_validation(on: :create) do
    this_password = secure_password
    self.password = this_password
    self.password_confirmation = this_password
  end
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  has_and_belongs_to_many :pages
  has_many :contact_forms, dependent: :destroy

  dragonfly_accessor :profile_image # to be removed

  mount_uploader(:avatar, ImageUploader)
  attr_accessor(:remove_avatar)

  translates :title

  enum role: %i[admin editor events]
  enum locale: %i[sv en]

  def send_password_selection_email
    raw, enc = Devise.token_generator.generate(self.class,
                                               :reset_password_token)

    self.reset_password_token   = enc
    self.reset_password_sent_at = Time.current
    save(validate: false)
    UserMailer.password_reset(self, raw).deliver_now
  end

  def name_with_email
    "#{name} - #{email}"
  end

  def thumb
    avatar.thumb.url if avatar.present?
  end
end
