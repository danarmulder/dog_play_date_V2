$(document).ready(function(){
  $('#reply').on ('click', function(){
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
});
