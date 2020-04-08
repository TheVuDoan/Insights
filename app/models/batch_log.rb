class BatchLog < ApplicationRecord
  enum result: {success: 1, failure: -1}

  def finish!
    update!(result: :success, end_at: Time.current)
  end

  def failed!
    update!(result: :failure, end_at: Time.current)
  end
end