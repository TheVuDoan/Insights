module Admins
  class BatchLogsController < BaseController  
    def index
      @batch_logs = BatchLog.all.order(id: :desc).page(params[:page]).per(20)
    end
  end
end
