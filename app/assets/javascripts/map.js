$(document).ready(function(){
  var geocoder;
  var map;
  var mapOptions;
  var newLatLng;
  var newLat;
  var newLng;
  var latlng;
  var mapElement;


  function initialize() {
    geocoder = new google.maps.Geocoder();
    var userZipcode = $('#map-canvas').attr("data-user-zipcode");
    var otherZipcode = $('#map-canvas').attr("data-user-zipcode");
    geocoder.geocode({'address': userZipcode}, function(results, status){
      if(status == google.maps.GeocoderStatus.OK) {
        newLatLng = results[0].geometry.location;
        newLat = (newLatLng["k"]);
        newLng = (newLatLng["D"]);
        latlng = new google.maps.LatLng(newLat, newLng);
        var mapOptions = {
          zoom: 13,
          center: latlng
        }
        map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions);
        var marker = new google.maps.Marker({
          map: map,
          position: results[0].geometry.location,
        });


        var request = {
          location: latlng,
          radius: '1000',
          types: ['park'],
          rankBy: google.maps.places.RankBy.PROMINENCE
        };
        infowindow = new google.maps.InfoWindow();
        var service =  new google.maps.places.PlacesService(map);
        service.nearbySearch(request, callback);
      } else {
        console.log("Geocode was not successful for the following reason: " + status);
      };

    });
  }

  function callback(results, status){
    var mapDiv = document.getElementById('map-segment');
    if(status == google.maps.places.PlacesServiceStatus.OK){
      for(var i= 0; i< results.length; i++){
        var place = results[i];
        createMarker(results[i]);
        var itemDiv = document.createElement('div');
        itemDiv.className = "item";
        mapDiv.appendChild(itemDiv);;
        var mapIcon = document.createElement('i');
        mapIcon.className = "map marker icon";
        itemDiv.appendChild(mapIcon);
        var contentDiv = document.createElement('div');
        contentDiv.className = "content";
        itemDiv.appendChild(contentDiv);
        var placeHeader = document.createElement('div');
        placeHeader.className = "header";
        placeHeader.innerText = results[i]["name"];
        placeHeader.id = results[i]["name"];
        var place_name = placeHeader.innerText;
        contentDiv.appendChild(placeHeader);
      }
    }
  }


  function createMarker(place){
    var placeLoc = place.geometry.location;
    var marker = new google.maps.Marker({
      map: map,
      position: place.geometry.location
    });
    google.maps.event.addListener(marker, 'mouseover', function() {
      infowindow.setContent(place.name);
      var place_name = document.getElementById(place.name);
      infowindow.open(map, this);
        place_name.style.color = "#00b2f3";
    });
    google.maps.event.addListener(marker, 'mouseout', function() {
      infowindow.setContent(place.name);
      var place_name = document.getElementById(place.name);
      place_name.style.color = "rgba(0, 0, 0, 0.8)";
      infowindow.open(map, this);
    });
  }


  $('document').ready(function(){
    google.maps.event.addDomListener(window, 'load', initialize);
  });
});
