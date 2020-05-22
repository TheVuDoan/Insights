$(document).on('turbolinks:load', function() {
  $(function() {
    $('.card-report').on('click', function() {
      const post_id = $(this).data('post_id')
      const report_reason_id = $(this).data('report_reason_id')
      $.post('/reports', { post_id: post_id, report_reason_id: report_reason_id }, function() {
        location.reload()
      });
    })
  })
});