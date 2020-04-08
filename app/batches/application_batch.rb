class ApplicationBatch
  attr_accessor :log

  class << self
    def execute(*args)
      new.execute(*args)
    end

    def batch_name
      name
    end
  end

  def execute(*args)
    start_log
    process(*args)
    end_log
  rescue => e
    error_log(e)
  end

  def logger
    @logger ||= Logger.new('log/batch.log')
  end

  private

  def start_log
    logger.info("#{batch_name}::execute started")
    self.log = BatchLog.create!(batch: batch_name, start_at: Time.current)
  end

  def end_log
    log.finish!
    logger.info("#{batch_name}::execute completed")
  end

  def error_log(e)
    log.failed!
    logger.error "Error: #{e}: #{e.message}"
    e.backtrace.each { |trace| logger.info "\t#{trace}" }
  end

  def process(*)
    raise NotImplementedError, "You should implement #{self.class.name}#execute."
  end

  def batch_name
    self.class.batch_name
  end
end