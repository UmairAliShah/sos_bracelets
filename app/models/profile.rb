class Profile < ApplicationRecord
  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :country, presence: true
  validates :phone, presence: true
  validates :avatar, presence: true

  attr_accessor :avatar, :avatar_cache, :remove_avatar

  has_attached_file :avatar,
  styles: { medium: "300x300#", thumb: "150x150#" },
  default_url: "/images/:style/user.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/


  belongs_to :user
  belongs_to :team_profile
  has_many :contacts, as: :contactable, dependent: :destroy
end
