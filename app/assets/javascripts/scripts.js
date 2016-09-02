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
      var options = {year: "numeric", month: "short", day: "numeric", hour: "2-digit", minute: "2-digit"};
      for(var i = 0; i < data.posts.length; i++){
        var form_date = new Date(data.posts[i].created_at);
        str += "<h3><a href='/messages/"+data.posts[i].id+"'>What would you do if you "+data.posts[i].content+"</a></h3>"
        str += "<p>"+data.likes[i]+" likes / "+data.comments[i]+" comments / "
        str += form_date.toLocaleTimeString('en-us', options)+"</p>"
      }
      $("div.panel-body").html(str);
    } );
    e.preventDefault();
    // return false;
});

});