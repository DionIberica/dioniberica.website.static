require 'byebug'

def localize(model, field)
  translations = I18n.available_locales.map do |locale|
    I18n.with_locale(locale) do
      [locale.to_sym, model.send(field)]
    end
  end

  Hash[*translations.flatten(1)]
end

policy = [dato.policy_legaladvise, dato.policy_return, dato.policy_generalterm, dato.policy_privacy, dato.policy_contest].map do |item|
  {
    title: localize(item, 'title'),
    text: localize(item, 'text'),
  }
end

create_data_file("_data/policy_legaladvise.yml", :yaml, policy[0])
create_data_file("_data/policy_return.yml", :yaml, policy[1])
create_data_file("_data/policy_generalterm.yml", :yaml, policy[2])
create_data_file("_data/policy_privacy.yml", :yaml, policy[3])
create_data_file("_data/policy_contest.yml", :yaml, policy[4])

gallery =  dato.product.gallery.map do |image|
  image.url(w: 600)
end

create_data_file("_data/product.yml", :yaml, {
  gallery: gallery,
})

faqs = dato.faqs.map do |faq|
  {
    kind: faq.kind,
    title: localize(faq, 'title'),
    description: localize(faq, 'description'),
  }
end

create_data_file("_data/faqs.yml", :yaml, faqs)

recomendations = dato.recomendations.map do |recomendation|
  {
    icon: recomendation.icon,
    title: localize(recomendation, 'title'),
    text: localize(recomendation, 'text'),
  }
end

create_data_file("_data/recomendations.yml", :yaml, recomendations)

shops = dato.shops.map do |shop|
  {
    name: shop.name,
    kind: shop.kind,
    target: shop.target,
    latitude: shop.latitude,
    longitude: shop.longitude,
    address: shop.address,
    monday: shop.monday,
    tuesday: shop.tuesday,
    wednesday: shop.wednesday,
    thursday: shop.thursday,
    friday: shop.friday,
    saturday: shop.saturday,
    sunday: shop.sunday,
  }
end

create_data_file("_data/shops.yml", :yaml, shops)


steps = dato.steps.map do |step|
  {
    text: localize(step, 'text'),
    icon: step.icon,
  }
end

create_data_file("_data/steps.yml", :yaml, steps)

testimonials = dato.testimonials.map do |testimonial|
  {
    target: testimonial.target,
    name: testimonial.name,
    role: localize(testimonial, 'role'),
    description: localize(testimonial, 'description'),
    photo: testimonial.photo && testimonial.photo.url(w: 150),
  }
end

create_data_file("_data/testimonials.yml", :yaml, testimonials)
