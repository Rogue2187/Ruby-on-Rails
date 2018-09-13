$(function(){
    // フィルターボタンが押された時の処理
    $(".result-header__filter").css("click", "none");
    $(".result-header__right__button").click(function(){
        // フィルターの表示、非表示を切り替える
        $(".result-header__filter").toggle();
    });
});
