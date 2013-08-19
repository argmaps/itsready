class NotifiesCustomer
  attr_reader :notification

  def initialize(notification)
    @notification = notification
  end

  def run
    texter = SmsClient.new
    text_msg = texter.send(notification.customer.full_phone, notification.message)
    notification.sent_at = text_msg.refresh.date_sent
    notification.save
  end
end
