class MontageWorker
  include Sidekiq::Worker
  sidekiq_options retry: 2 # only 2 retries, mostly errors will be 404s on the image

  def perform(row)
    m = Montage.new
    m.left_image = row[0]
    m.right_image = row[1]
    m.save # Silent error handling to allow idempotent uploads
  end
end
