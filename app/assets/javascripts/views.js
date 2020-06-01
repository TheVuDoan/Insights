$(document).on('turbolinks:load', function() {
  $(function() {
    $('.card-view-url').on('click', function() {
      const post_id = $(this).data('post_id')
      const is_recommend = $(this).data('is_recommend')
      $.post('/views', { post_id: post_id, is_recommend: is_recommend }, function() {});
    })
  })
});
