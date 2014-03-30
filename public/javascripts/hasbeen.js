var locations = [];

function map() {
  var bounds = new google.maps.LatLngBounds();
  var geocoder = new google.maps.Geocoder();
  var $bar_container = $('#bar');
  var $map_container = $('#map');
  $map_container.css('margin-top', $bar_container.height());
  var map = new google.maps.Map($map_container.get(0), { disableDefaultUI: true });
  function setup_locations() {
    var single_location = locations.pop();
    geocoder.geocode({ address: single_location }, function(results, status) {
      if (status == google.maps.GeocoderStatus.OK) {
        var marker = new google.maps.Marker({
          position: results[0].geometry.location,
          map: map,
          title: single_location
        });
        bounds.extend(marker.getPosition());
      }
    });
    locations.length ? window.setTimeout(setup_locations, 100) : map.fitBounds(bounds)
  }
  if(locations.length == 1) {
    geocoder.geocode({ address: locations.pop() }, function(results, status) {
      if (status == google.maps.GeocoderStatus.OK) {
        map.fitBounds(results[0].geometry.viewport);
        map.setCenter(results[0].geometry.location);
      }
    });
  }
  else {
    google.maps.event.addDomListener(window, 'load', setup_locations);
  }
}

/**
 * I've always wanted to define that function!
 */
function goto(single_location) {
  locations = [decodeURIComponent(single_location)];
  map();
}

function overview(location_list) {
  locations = location_list;
  map();
}