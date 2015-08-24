json.cache! do
  json.array! @applications do |application|
    json.extract! application, :name, :slug, :active, :locale, :subscription_based, :orders_count
  end
end
