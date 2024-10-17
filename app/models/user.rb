class User < ApplicationRecord
  authenticates_with_sorcery!

  has_secure_password
  belongs_to :department
  has_and_belongs_to_many :favorited_messages, class_name: 'Message', join_table: 'favorites'
  has_many :patients

  attr_accessor :employee_keyword

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  validate :correct_employee_keyword, on: :create
  validates :reset_password_token, presence: true, uniqueness: true, allow_nil: true

  def generate_password_reset_token!
    self.password_reset_token = SecureRandom.urlsafe_base64.to_s
    self.password_reset_sent_at = Time.current
    save!(validate: false)
  end

  def clear_password_reset_token!
    self.password_reset_token = nil
    self.password_reset_sent_at = nil
    save!
  end

  def password_reset_expired?
    password_reset_sent_at < 24.hours.ago
  end

  def self.create_guest_user
    create!(
      email: 'guest@example.com',
      password: 'guestpassword',
      guest: true
    )
  end

  def guest?
    email == 'guest@example.com'
  end

  private
  
  def correct_employee_keyword
    if employee_keyword != 'kiradc1624'
      errors.add(:employee_keyword, '正しいキーワードを入力してください')
    end
  end
end
