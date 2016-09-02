$(document).ready(function(){
  // on click 

$('div.btn-group ul.dropdown-menu li a').click(function (e) {
    var $div = $(this).parent().parent().parent(); 
    var $btn = $div.find('button');
    $btn.html($(this).text() + ' <span class="caret"></span>');
    $div.removeClass('open');
    var id = $(this).attr("id");
    // e.preventDefault();
    $.post("/messages/sort", {option: id}, function(data){
      console.log(data);
      var str = ""
      for(var i = 0; i < data.posts.length; i++){
        str += "<h3><a href='/messages/"+data.posts[i].id+"'>"+data.posts[i].content+"</a></h3>"
        str += "<p>"+data.likes[i]+" likes / "+data.comments[i]+" comments</p>"
      }
      $("div.panel-body").html(str);
    } );
    e.preventDefault();
    // return false;
});

});


//   $('#new_user_form').submit(function(){
//     $.post(
//       $(this).attr('action'),
//       $(this).serialize(),
//       function(data){
//         console.log('Data Received from the Ajax call', data);
//         //put additional codes here to update html, etc.
//         //for example things like
//         $('#message').html(data.message);
//       },
//       "json"
//     );
//     return false;
//   });
// });