var shops = {{ site.data.shops | where: 'target', include.shops_locale | jsonify }};
