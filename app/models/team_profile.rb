class TeamProfile < ApplicationRecord
  validates :name, presence: true, length: { minimum: 5 }
  validates :country, presence: true
  validates :avatar, presence: true
  validates :members, presence: true


  attr_accessor :avatar, :avatar_cache, :remove_avatar

  belongs_to :team
  has_one :leader
  has_many :invitations
  has_many :profiles

  has_attached_file :avatar,
  styles: { medium: "300x300#", thumb: "150x150#" },
  default_url: "/images/:style/user.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  def country_name
    country = ISO3166::Country[country_code]
    country.translations[I18n.locale.to_s] || country.name
  end
end
