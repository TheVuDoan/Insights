$(document).on('turbolinks:load', function() {
  $(function() {
    $('.card-like').on('click', function() {
      const post_id = $(this).data('post_id')
      $.post('/likes', { post_id: post_id }, function() {
        location.reload()
      });
    })
  })
});
