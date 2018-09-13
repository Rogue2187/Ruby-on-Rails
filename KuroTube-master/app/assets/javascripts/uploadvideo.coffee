# タグ入力画面
$(document).on 'ready page:load', ->
  $('#video-tags').tagit
    fieldName:   'video[tag_list]'
    singleField: true

# タグのデータ引き渡し
  if gon.video_tags?
    for tag in gon.video_tags
      $('#video-tags').tagit 'createTag', tag
