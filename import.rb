require "dato"
require "pp"
require "csv"
require "jekyll"
require "byebug"

def transform(localized, ignored, booleanized, floatized, data)
  locales = %w(es en ca pt)

  data.map do |item|
    localized.each do |field|

      item[field] = {}

      locales.each do |locale|
        item[field][locale] = item["#{field}_#{locale}"]
        item.delete("#{field}_#{locale}")
      end
    end

    booleanized.each do |field|
      item[field] = item[field].present?
    end

    floatized.each do |field|
      item[field] = item[field].gsub(/,/, '.').to_f
    end

    item.except(*ignored)
  end
end

client = Dato::Site::Client.new(ENV['DATO_API_TOKEN'])

pp client.item_types.all

#faqs = CSV.read('./_data/faq.csv', {
#  :headers  => true,
#  :encoding => Jekyll.configuration["encoding"],
#}).map(&:to_hash)
#
#transform(%w(title description), %w(), %w(frequent), %w(), faqs).each do |item|
#  dato = item.merge(item_type: "11862")
#
#  client.items.create(dato)
#end

# benefits = CSV.read('./_data/benefits.csv', {
#   :headers  => true,
#   :encoding => Jekyll.configuration["encoding"],
# }).map(&:to_hash)
# 
# transform(%w(title), %w(), %w(), %w(), benefits).each do |item|
#   dato = item.merge(item_type: "11866")
# 
#   client.items.create(dato)
# end

# testimonials = CSV.read('./_data/testimonials.csv', {
#   :headers  => true,
#   :encoding => Jekyll.configuration["encoding"],
# }).map(&:to_hash)
# 
# transform(%w(role description), %w(photo), %w(), %w(), testimonials).each do |item|
#   dato = item.merge(item_type: "11865", target: item['idioma'])
# 
#   dato = dato.except('idioma')
# 
#   client.items.create(dato)
# end

recomendations = CSV.read('./_data/recomendations.csv', {
  :headers  => true,
  :encoding => Jekyll.configuration["encoding"],
}).map(&:to_hash)

transform(%w(title text), %w(show key), %w(), %w(), recomendations).each do |item|
  dato = item.merge(item_type: "11863", visible: true)

  client.items.create(dato)
end

#shops = CSV.read('./_data/shops.csv', {
#  :headers  => true,
#  :encoding => Jekyll.configuration["encoding"],
#}).map(&:to_hash)
#
#transform(%w(), %w(photo), %w(), %w(latitude longitude), shops).each do |item|
#  dato = item.merge(item_type: "11867", target: item['idioma'], kind: 'pharmacy')
#
#  dato = dato.except('idioma', 'type')
#
#  client.items.create(dato)
#end

# steps = CSV.read('./_data/steps.csv', {
#   :headers  => true,
#   :encoding => Jekyll.configuration["encoding"],
# }).map(&:to_hash)
# 
# transform(%w(title text), %w(photo key), %w(), %w(), steps).each do |item|
#   dato = item.merge(item_type: "11864")
# 
#   client.items.create(dato)
# end
