class Order < ActiveRecord::Base

	# SEARCH
  # ------------------------------------------------------------------------------------------------------
  include PgSearch
  # multisearchable :against => [:uid, :date, :client_email, :country, :city, :gift, :coupon_code]
  pg_search_scope :search_by_keyword,
                  :against => [:uid, :client_email, :country, :city, :coupon_code, :keywords],
                  :using => {
                    :tsearch => {
                      :prefix => true # match any characters
                    }
                  },
                  :ignoring => :accents


  # ASSOCIATIONS
  # ------------------------------------------------------------------------------------------------------
  belongs_to :application, counter_cache: true

  # SCOPES
  # ------------------------------------------------------------------------------------------------------
  scope :by_month,      -> (month) { where("created_at BETWEEN '#{month.beginning_of_month}' AND '#{month.end_of_month}'") }
  scope :by_day,        -> (day) { where("created_at BETWEEN '#{day.beginning_of_day}' AND '#{day.end_of_day}'") }
  scope :within_period, -> (from, to) { where(date: (from..to)) }
  scope :from_date,     -> (from) { where("created_at >= ?", from) }
  scope :to_date,       -> (to) { where("created_at <= ?", to) }


  # VALIDATIONS
  # ------------------------------------------------------------------------------------------------------
  validates_presence_of :uid, :date, :currency, :amount, :shipping, :total_price, :country,
   	                    :city, :client_email
  validates_uniqueness_of :uid, scope: :application_id


  # CALLBACKS
  # ------------------------------------------------------------------------------------------------------
  before_create :format_fields
  before_save :sync_keywords


  # INSTANCE METHODS
  # ------------------------------------------------------------------------------------------------------

  private

    def format_fields
    	self.currency     = currency.downcase if currency
    	self.country      = country.downcase if country
    	self.city         = city.downcase if city
      self.client_email = client_email.downcase if client_email
    end

    def sync_keywords
      keywords = []
      keywords << self.date.strftime("%d/%m/%Y")
      keywords << self.application.name.downcase.to_s
      self.keywords = keywords.join(", ")
    end

end
