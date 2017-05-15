var shops = {{ site.data.shops | where: 'idioma', include.shops_locale | jsonify }};
