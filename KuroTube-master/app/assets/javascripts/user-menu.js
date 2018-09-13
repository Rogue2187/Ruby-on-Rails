$(function() {
  // user-menu表示
  $(document).on('click','.google-user-login', function(){
    var userMenu = $("#user-menu");
    userMenu.show();
    $('body').append('<div id="overlay">');
    $('#overlay').show();
  });
  // user-menu非表示
  $(document).on('click', '#overlay', function(){
    var userMenu = $("#user-menu");
    userMenu.hide();
    $('#overlay').remove();
  });
});













