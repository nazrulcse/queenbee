class Order < ActiveRecord::Base

	# SEARCH
  # ------------------------------------------------------------------------------------------------------
  include PgSearch
  #multisearchable against: [:uid, :source]
  pg_search_scope :search_by_keyword, 
                  :against => [:uid, :source, :client_email, :country, :city],
                  :using => {
                    :tsearch => {
                      :prefix => true # match any characters
                    }
                  },
                  :ignoring => :accents

  # VALIDATIONS
  # ------------------------------------------------------------------------------------------------------
  validates_presence_of :uid, :source, :date, :currency, :amount, :shipping, :total_price, :country,
    	                  :city, :client_email


  # CALLBACKS
  # ------------------------------------------------------------------------------------------------------
  before_create :format_fields


  private

    def format_fields
    	self.source       = source.downcase if source
    	self.currency     = currency.downcase if currency
    	self.country      = country.downcase if country
    	self.city         = city.downcase if city
      self.client_email = client_email.downcase if client_email
    end

end
