class Order < ActiveRecord::Base

	# SEARCH
  # ------------------------------------------------------------------------------------------------------
  include PgSearch
  multisearchable :against => [:uid, :date, :client_email, :country, :city, :gift, :coupon_code]
  pg_search_scope :search_by_keyword, 
                  :against => [:uid, :date, :client_email, :country, :city, :gift, :coupon_code],
                  :using => {
                    :tsearch => {
                      :prefix => true # match any characters
                    }
                  },
                  :ignoring => :accents


  # ASSOCIATIONS
  # ------------------------------------------------------------------------------------------------------
  belongs_to :application, counter_cache: true


  # VALIDATIONS
  # ------------------------------------------------------------------------------------------------------
  validates_presence_of :uid, :date, :currency, :amount, :shipping, :total_price, :country,
   	                    :city, :client_email
  validates_uniqueness_of :uid, scope: :application_id


  # CALLBACKS
  # ------------------------------------------------------------------------------------------------------
  before_create :format_fields


  # INSTANCE METHODS
  # ------------------------------------------------------------------------------------------------------

  private

    def format_fields
    	self.currency     = currency.downcase if currency
    	self.country      = country.downcase if country
    	self.city         = city.downcase if city
      self.client_email = client_email.downcase if client_email
    end

end
