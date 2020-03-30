$(document).ready(function () {
  $(function() {
    $('.card-bookmark').on('click', function() {
      const post_id = $(this).data('post_id')
      $.post('/bookmarks', { post_id: post_id }, function() {
        location.reload()
      });
    })
  })
});