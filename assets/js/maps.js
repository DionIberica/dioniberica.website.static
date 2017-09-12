function initShopsMap() {
  var $map = $('#shops-map');
  var latitude = $map.data('latitude');
  var longitude = $map.data('longitude');

  var monday = $map.data('monday');
  var tuesday = $map.data('tuesday');
  var wednesday = $map.data('wednesday');
  var thursday = $map.data('thursday');
  var friday = $map.data('friday');
  var saturday = $map.data('saturday');
  var sunday = $map.data('sunday');

  var centered = new google.maps.LatLng(longitude, latitude);

  var mapOptions = {
    zoom: 10,
    center: centered,
    mapTypeId: google.maps.MapTypeId.ROADMAP,
    scrollwheel: false
  };
  var map = new google.maps.Map($map.get(0), mapOptions);
  var markers = [];

  function closeAllInfoWindows(map) {
    markers.forEach(function(marker) {
      marker.infowindow.close(map, marker);
    });
  }

  shops.forEach(function (shop) {
    var week = [
      [monday, shop.monday],
      [tuesday, shop.tuesday],
      [wednesday, shop.wednesday],
      [thursday, shop.thursday],
      [friday, shop.friday],
      [saturday, shop.saturday],
      [sunday, shop.sunday]
    ].filter(function (day) { return !!day[1]; });

    var contentString = '<b>' + shop.name + '</b><br/><br/>' + week.map(function (day) {
      return day[0] + ': ' + day[1]
    }).join('<br>');

    var infowindow = new google.maps.InfoWindow({
      content: contentString
    });

    var marker = new google.maps.Marker({
      position: {
        lat: shop.latitude,
        lng: shop.longitude
      },
      map: map,
      title: shop.name,
      infowindow: infowindow
    });

    markers.push(marker);

    google.maps.event.addListener(marker, 'click', function() {
      closeAllInfoWindows(map);
      this.infowindow.open(map, this);
    });
  });
}

function initContactMap() {
  var $map = $('#map');
  var latitude = $map.data('latitude');
  var longitude = $map.data('longitude');
  var label = $map.data('label');

  var centered = new google.maps.LatLng(longitude, latitude);

  var mapOptions = {
    zoom: 15,
    center: centered,
    mapTypeId: google.maps.MapTypeId.ROADMAP,
    scrollwheel: false,
    draggable: false
  };

  var map = new google.maps.Map($map.get(0), mapOptions);

  var contentString = '<p style="line-height: 20px;">' + label + '</p>';

  var infowindow = new google.maps.InfoWindow({
    content: contentString
  });

  var marker = new google.maps.Marker({
    position: centered,
    map: map,
    title: 'Marker'
  });

  google.maps.event.addListener(marker, 'click', function() {
    infowindow.open(map, marker);
  });
}

function initMaps() {
  initShopsMap();
  initContactMap();
}
