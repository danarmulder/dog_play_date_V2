$(document).ready(function(){
  L.mapbox.accessToken = 'pk.eyJ1IjoiZGF5eW51aGhoIiwiYSI6IlNrUWlXd0kifQ.PkwjuKO6Clksu2OGIoePeA';
  $( "#mapbox_map" ).load(mapBox());

  function mapBox(){
    var latitude = $('#mapbox_map')[0].dataset.latitude;
    var longitude = $('#mapbox_map')[0].dataset.longitude;
    var map = L.mapbox.map('mapbox_map', 'examples.map-i86nkdio').setView([latitude, longitude], 13);
  }
});
