class MontageWorker
  include Sidekiq::Worker

  def perform(row)
    m = Montage.new
    m.left_image = row[0]
    m.right_image = row[1]
    m.save # Silent error handling to allow idempotent uploads
  end
end
