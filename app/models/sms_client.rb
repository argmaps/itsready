class SmsClient
  attr_reader :client

  def initialize
    sid, token = ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
    @client = Twilio::REST::Client.new(sid, token)
  end

  def send(phone_number, msg)
    params = {
      from: ENV['TWILIO_PHONE_NUMBER'],
      to: phone_number,
      body: msg
    }
    client.account.sms.messages.create(params)
  end
end
