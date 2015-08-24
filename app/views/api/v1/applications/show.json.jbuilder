json.cache! do
  json.extract! @application, :name, :slug, :active, :locale, :subscription_based, :orders_count
end
