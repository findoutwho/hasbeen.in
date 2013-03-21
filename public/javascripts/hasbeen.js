/**
 * I've always wanted to define that function!
 */
function goto(location) {
  if(location) {
    location = unescape(location);

    var geocoder        = new google.maps.Geocoder();
    var geocoderRequest = { address: location }

    geocoder.geocode(geocoderRequest, function(results, status) {
      if (status == google.maps.GeocoderStatus.OK) {
        var mapOptions = {
          disableDefaultUI: true,
          mapTypeId:        google.maps.MapTypeId.ROADMAP
        };
        var map = new google.maps.Map(document.getElementById("map"), mapOptions);
        map.fitBounds(results[0].geometry.viewport);
        map.setCenter(results[0].geometry.location);
      }
    });
  }
}

