$(document).ready(function(){
  $('#reply-action').on ('click', function(){
    var sender_id= $(this).data('id');
    var body = $('textarea').val();
    var conversation_id = $('h3')[0].id;
    var url = '/conversations/'+ conversation_id + '/messages';
    $.ajax(url, {type: 'post',
      data: {
        message:{
          user_id: sender_id,
          body: body,
          conversation_id: conversation_id,
        }
      }
    }).done(function(comment){
      $('textarea').val('');
      var image = $('#current_user')[0].src;
      var userName = $('#user_name').data('id');
      var source = $('#add-newest-comment').html();
      var template = Handlebars.compile(source);
      console.log(image);
      var context = {
        userImage: image,
        author: userName,
        convoText: comment.body,
      };
      var newComment = template(context);

      $('#container').append(newComment);
    });
  });

  var map;
  var infowindow;

  function initialize() {
    var pyrmont = new google.maps.LatLng(-33.8665433, 151.1956316);

    map = new google.maps.Map(document.getElementById('map-canvas'), {
      center: pyrmont,
      zoom: 15
    });

    var request = {
      location: pyrmont,
      radius: 500,
      types: ['park']
    };
    infowindow = new google.maps.InfoWindow();
    var service = new google.maps.places.PlacesService(map);
    service.nearbySearch(request, callback);
  }

  function callback(results, status) {
    if (status == google.maps.places.PlacesServiceStatus.OK) {
      for (var i = 0; i < results.length; i++) {
        createMarker(results[i]);
      }
    }
  }
  function createMarker(place) {
  var placeLoc = place.geometry.location;
  var marker = new google.maps.Marker({
    map: map,
    position: place.geometry.location
  });

  google.maps.event.addListener(marker, 'click', function() {
    infowindow.setContent(place.name);
    infowindow.open(map, this);
  });
}

  google.maps.event.addDomListener(window, 'load', initialize);

});
