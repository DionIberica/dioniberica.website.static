def localize(model, field)
  translations = I18n.available_locales.map do |locale|
    I18n.with_locale(locale) do
      [locale.to_sym, model.send(field)]
    end
  end

  Hash[*translations.flatten(1)]
end

steps = dato.steps.map do |step|
  {
    title: localize(step, 'title'),
    text: localize(step, 'text'),
    icon: step.icon
  }
end

create_data_file("_data/steps.yml", :yaml, steps)

testimonials = dato.testimonials.map do |testimonial|
  {
    name: testimonial.name,
    role: localize(testimonial, 'role'),
    description: localize(testimonial, 'description'),
    target: testimonial.target,
    photo: testimonial.photo.url(w: 150, h: 150)
  }
end

create_data_file("_data/testimonials.yml", :yaml, testimonials)

shops = dato.shops.map do |shop|
  {
    name: shop.name,
    kind: shop.kind,
    latitude: shop.latitude,
    longitude: shop.longitude,
    address: shop.address,
    target: shop.target,
    monday: shop.monday,
    tuesday: shop.tuesday,
    wednesday: shop.wednesday,
    thursday: shop.thursday,
    friday: shop.friday,
    saturday: shop.saturday,
    sunday: shop.sunday
  }
end

create_data_file("_data/shops.yml", :yaml, shops)

faqs = dato.faqs.map do |faq|
  {
    title: localize(faq, 'title'),
    description: localize(faq, 'description'),
    frequent: faq.frequent
  }
end

create_data_file("_data/faqs.yml", :yaml, faqs)

recomendations = dato.recomendations.map do |recomendation|
  {
    title: localize(recomendation, 'title'),
    text: localize(recomendation, 'text'),
    visible: recomendation.visible,
    icon: recomendation.icon
  }
end

create_data_file("_data/recomendations.yml", :yaml, recomendations)

benefits = dato.benefits.map do |benefit|
  {
    title: localize(benefit, 'title'),
    component: benefit.component
  }
end

create_data_file("_data/benefits.yml", :yaml, benefits)
