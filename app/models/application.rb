class Application < ActiveRecord::Base
	require 'identicon'

  # SEARCH
  # ------------------------------------------------------------------------------------------------------
  include PgSearch
  multisearchable :against => [:name]


	# ASSOCIATIONS
  # ------------------------------------------------------------------------------------------------------
  has_many :orders, dependent: :destroy


  # SCOPES
  # ------------------------------------------------------------------------------------------------------
  scope :active, -> { where(active: true) }


  # VALIDATIONS
  # ------------------------------------------------------------------------------------------------------
  validates_presence_of :name


  # CALLBACKS
  # ------------------------------------------------------------------------------------------------------
  before_create :format_fields


  # INSTANCE METHODS
  # ------------------------------------------------------------------------------------------------------

  private

    def format_fields
  	  self.auth_token = SecureRandom.hex
      self.identicon = Identicon.data_url_for name, 128, [255, 255, 255]
      self.slug = slug.present? ? slug.parameterize : name.parameterize
    end
end
