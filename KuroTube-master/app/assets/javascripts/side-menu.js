$(function() {
  //サイドメニューボタンが押されたときの処理 押し出し型
  // $(".side-menu-button").on("click", function(){
  //   // クラスを変数定義
  //   var sideMenu = $(".side-menu")
  //   var contents = $("#contents-wrapper")
  //   // スライドメニューが非表示
  //   if(sideMenu.hasClass("slide-off")){
  //     sideMenu.removeClass("slide-off").animate({'left':'0'},100).addClass('slide-on');
  //     contents.animate({'marginLeft':'240px'},400).css("width","calc(100% - 240px)");
  //   }
  //   // スライドメニューが表示中
  //   else{
  //     sideMenu.addClass("slide-off").animate({'left':'-240px'},100).removeClass("slide-on");
  //     contents.animate({"marginLeft":"0"},300).css("width","100%");
  //   }
  // });

    //サイドメニューボタンが押されたときの処理 モーダル型
  $(".side-menu-button").on("click", function(){
    // クラスを変数定義
    var sideMenu = $(".side-menu")
    var contents = $("#contents-wrapper")
    // スライドメニューが非表示
    if(sideMenu.hasClass("slide-off")){
      sideMenu.removeClass("slide-off").animate({'left':'0'},100).addClass('slide-on');
      $('body').append('<div id="overlay-shadow">');
      $('#overlay-shadow').show();
    }
    // スライドメニューが表示中
    else{
      sideMenu.addClass("slide-off").animate({'left':'-240px'},100).removeClass("slide-on");
      $('#overlay-shadow').hide().remove();
    }
    // 外部をクリックしても閉じる
    $(document).on('click', '#overlay-shadow', function(){
      sideMenu.addClass("slide-off").animate({'left':'-240px'},100).removeClass("slide-on");
      $('#overlay-shadow').hide().remove();
    })
  });
});
