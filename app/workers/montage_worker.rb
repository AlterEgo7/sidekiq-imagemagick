class MontageWorker
  include Sidekiq::Worker

  def perform(row)
    m = Montage.new
    m.left_image = open(row[0])
    m.right_image = open(row[1])
    m.save # Silent error handling to allow idempotent uploads
  end
end
