$(document).on('turbolinks:load', function() {
  $(function() {
    $('.card-view-url').on('click', function() {
      const post_id = $(this).data('post_id')
      $.post('/views', { post_id: post_id }, function() {});
    })
  })
});
