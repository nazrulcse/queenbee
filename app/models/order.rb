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
  scope :by_month,      -> (month)    { where("date BETWEEN '#{month.beginning_of_month}' AND '#{month.end_of_month}'") }
  scope :by_day,        -> (day)      { where("date BETWEEN '#{day.beginning_of_day}' AND '#{day.end_of_day}'") }
  scope :within_period, -> (from, to) { where(date: (from..to)) }
  scope :from_date,     -> (from)     { where("date >= ?", from) }
  scope :to_date,       -> (to)       { where("date <= ?", to) }


  # VALIDATIONS
  # ------------------------------------------------------------------------------------------------------
  validates_presence_of :uid, :date, :amount, :shipping, :total_price, :country,
   	                    :city, :client_email
  validates_presence_of :currency, unless: Proc.new{ |o| o.application.locale.present? }
  validates_uniqueness_of :uid, scope: :application_id


  # CALLBACKS
  # ------------------------------------------------------------------------------------------------------
  before_save :format_fields, :sync_keywords


  # INSTANCE METHODS
  # ------------------------------------------------------------------------------------------------------
  def self.import_file(file)
    allowed_attributes = [ 'uid', 'client_email', 'country', 'city', 'products_count',
                           'date', 'currency', 'amount', 'shipping', 'total_price', 'gift',
                           'coupon', 'coupon_code', 'url', 'tax', 'source' ]
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      order = find_by_id(row['id']) || new
      order.attributes = row.to_hash.select { |k,v| allowed_attributes.include? k }
      order.save!
    end
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when '.csv'  then     Roo::Csv.new(file.path, nil, :ignore)
    when '.xls'  then  Roo::Excel.new(file.path,  nil, :ignore)
    when '.xlsx' then Roo::Excelx.new(file.path,  nil, :ignore)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end

  private

  def format_fields
    self.currency     = currency.present? ? currency.downcase : application.try(:default_currency)
  	self.country      = country.downcase if country
  	self.city         = city.downcase if city
    self.client_email = client_email.downcase if client_email
    self.week_day     = date.to_date.cwday if date
    self.month_day    = date.day if date
    self.hour         = date.to_time.hour if date
  end

  def sync_keywords
    keywords = []
    keywords << self.date.strftime("%d/%m/%Y")
    keywords << self.application.name.downcase.to_s
    self.keywords = keywords.join(", ")
  end
end
