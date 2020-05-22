class ReportsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    if !user_signed_in?
      redirect_to '/users/sign_in', alert: "Đăng nhập để sử dụng chức năng!"
    else 
      post_id = params[:post_id]
      report_reason_id = params[:report_reason_id]
      report = Report.where(post_id: post_id, user_id: current_user.id).first
      if report.nil?
        report = Report.create(post_id: post_id, user_id: current_user.id, report_reason_id: report_reason_id)
      end
      report_count = Report.where(post_id: post_id).count
      if report_count >= 2
        reported_post = Post.find(post_id)
        reported_post.status = 0
        reported_post.save
      end
    end
  end
end
