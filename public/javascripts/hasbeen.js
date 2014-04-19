function display_map(locations) {
  var bounds = new google.maps.LatLngBounds();
  var $bar_container = $('#bar');
  var $map_container = $('#map');
  $map_container.css('margin-top', $bar_container.height());
  var map = new google.maps.Map($map_container.get(0), { disableDefaultUI: true });
  jQuery.each(locations, function(index, single_location) {
    var pos = new google.maps.LatLng(single_location.lat, single_location.lng);
    if(locations.length > 1) {
      var marker = new google.maps.Marker({
        position: pos,
        map: map,
        title: single_location.name
      });
    }
    bounds.extend(pos);
  });
  map.fitBounds(bounds);
}

/**
 * I've always wanted to define that function!
 */
function goto(single_location) {
  var geocoder = new google.maps.Geocoder();
  var map = new google.maps.Map(document.getElementById('map'), { disableDefaultUI: true });
  geocoder.geocode({ address: decodeURIComponent(single_location) }, function(results, status) {
    if (status == google.maps.GeocoderStatus.OK) {
      map.fitBounds(results[0].geometry.viewport);
      map.setCenter(results[0].geometry.location);
    }
  });
}

function overview() {
  $.ajax({
    url: window.location.href + 'locations.json',
    type: 'get',
    dataType: 'json',
    success: function(data, status) {
      display_map(data.locations);
    }
  })
}