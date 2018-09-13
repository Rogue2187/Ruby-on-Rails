// コメント投稿時の、非同期でのコメント描画
$(function() {
  // submit押下後、非同期で追加するhtml。(_comments.html.hamlで記載しているものをhtmlに変換しjsonが渡るようにしたもの。)
  function buildCommentHtml(comment) {
    var html =
`<div class="comments-contents">
  <div class="comments-contents__thread">
    <div class="comments-contents__thread__comment">
      <div class="comments-contents__thread__comment__author-thumnail-area">
      <a class="comments-contents__thread__comment__author-thumnail-area__link"><img src=${comment.author_thumanil} class="comments-contents__thread__comment__author-thumnail-area__link__image"></a>
      </div>
      <div class="comments-contents__thread__comment__main">
        <div class="comments-contents__thread__comment__main__title">
          <a class="comments-contents__thread__comment__main__title__author-name">${comment.user_name}</a>
          <p class="comments-contents__thread__comment__main__title__published-time">${comment.date}</p>
        </div>
        <div class="comments-contents__thread__comment__main__content">${comment.content}</div>
        <div class="comments-contents__thread__comment__main__action-buttons">
          <span class="comments-contents__thread__comment__main__action-buttons__reply" id="${comment.id}"></span>
          <span class="comments-contents__thread__comment__main__action-buttons__bote-count">593</span>
          <span class="comments-contents__thread__comment__main__action-buttons__like-button glyphicon glyphicon-thumbs-up"></span>
          <span class="comments-contents__thread__comment__main__action-buttons__dislike-button glyphicon glyphicon-thumbs-down"></span>
        </div>
      </div>
    </div>
  </div>
</div>`;
    return html;
  }

  function buildReplyHtml(comment) {
    var html =
`
<div class="reply-comments-contents">
  <div class="reply-comments-contents__thread">
    <div class="reply-comments-contents__thread__comment">
      <div class="reply-comments-contents__thread__comment__author-thumnail-area">
        <a class="reply-comments-contents__thread__comment__author-thumnail-area__link"><img src=${comment.author_thumanil} class="reply-comments-contents__thread__comment__author-thumnail-area__link__image"></a>
      </div>
      <div class="reply-comments-contents__thread__comment__main">
        <div class="reply-comments-contents__thread__comment__main__title">
          <a class="reply-comments-contents__thread__comment__main__title__author-name">${comment.user_name}</a>
          <p class="reply-comments-contents__thread__comment__main__title__published-time">${comment.date}</p>
        </div>
        <div class="reply-comments-contents__thread__comment__main__content">${comment.content}</div>
        <div class="reply-comments-contents__thread__comment__main__action-buttons">
          <div class="reply-comments-contents__thread__comment__main__action-buttons__reply"></div>
          <span class="reply-comments-contents__thread__comment__main__action-buttons__bote-count">34</span>
          <span class="reply-comments-contents__thread__comment__main__action-buttons__like-button glyphicon glyphicon-thumbs-up"></span>
          <span class="reply-comments-contents__thread__comment__main__action-buttons__dislike-button glyphicon glyphicon-thumbs-down"></span>
        </div>
      </div>
    </div>
  </div>
</div>
`;
  return html;
  }

  // submit押下時、フォームの内容を非同期で追加表示
  $(function() {
    $('#js-new-comment').on('submit', function(e) {
      e.preventDefault();
      var formData = new FormData(this);
      var url = $(this).attr('action');
      $.ajax({
        url: url,
        type: "POST",
        dataType: 'json',
        data: formData,
        processData: false,
        contentType: false
      })
      .done(function(data) {
        var commentHtml = buildCommentHtml(data);
        $('.comments-contents-wrapper:last').append(commentHtml);
        // 投稿後、フォームの中身を消す
        $('#js-new-comment')[0].reset();
        console.log("success");
      })
      .fail(function() {
        console.log("error");
      })
      .always(function() {
        console.log("complete");
      });
      return false;
    });
  });

  // 返信フォームにてsubmit押下時、フォームの内容を非同期で追加表示
  $(function() {
    $(document).on("submit", "#js-new-reply", function (e) {
      e.preventDefault();
      var parentId = $(this).attr("data-parentId");
      var formData = new FormData(this);
      var url = $(this).attr('action');
      $.ajax({
        url: url,
        type: "POST",
        dataType: 'json',
        data: formData,
        processData: false,
        contentType: false
      })
      .done(function(data) {
        var replyHtml = buildReplyHtml(data);
        $('#reply_' + parentId).show();
        $('#reply_' + parentId).append(replyHtml);
        // 投稿後、フォームの中身を消す
        // TODO:うまくいっていないため修正必要
        $('#js-new-reply')[0].reset();
        console.log("success");
      })
      .fail(function() {
        console.log("error");
      })
      .always(function() {
        console.log("complete");
      });
      return false;
    });
  });

  // おためしだ
  $(function() {
    $(document).on("click", "#js-new-reply", function () {
      console.log("さそりだよー");
    });
  });

  // コメントフォームをクリックすると「キャンセル」「コメント」ボタンを表示
  $(function() {
    $('.comments-header__create').click(function(){
      if ($('.comments-header__create__buttons').is(':hidden')) {
        console.log("hidden");
        $('.comments-header__create__buttons').show();
      } else {
        console.log("visible");
        $('.comments-header__create__buttons').hide();
      }
    });
  });

  // コメントフォームの「キャンセル」ボタンをクリックすると「キャンセル」「コメント」ボタンを非表示
  // $(function() {
  //   $('.comments-header__create__buttons__cancel').click(function(){
  //     console.log("aaa");
  //     $('.comments-header__create__buttons').hide();
  //     console.log("bbb");
  //   });
  // });

  // 「返信」をクリックすると返信フォームを表示
  $(function() {
    $(document).on("click", '.comments-contents__thread__comment__main__action-buttons__reply', function(){
      console.log("aaa");
      var commentId = $(this).attr("id");
      console.log(commentId);
      $('#replyform_' + commentId).show();
    });
  });

  // 返信フォームの「キャンセル」をクリックすると返信フォームを非表示
  $(function() {
    $('.comments-contents__thread__comment__main__reply-form__buttons__cancel').click(function(){
      var commentId = $(this).attr("id");
      $('#replyform_' + commentId).hide();
    });
  });

  // 「x件すべての返信を表示」をクリックすると、返信コメントを表示
  $(function() {
    $(document).on("click", '.comments-contents__thread__comment__reply__text, .comments-contents__thread__comment__reply__icon', function(){
      console.log("aaa");
      var commentId = $(this).parent().attr("id");
      console.log(commentId);
      $('#reply_' + commentId).toggle();
      console.log("aaa");
    });
  });
});
