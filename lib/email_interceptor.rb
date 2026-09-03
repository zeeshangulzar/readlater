class EmailInterceptor
  def self.delivering_email(message)
    message.to = ENV.fetch("INTERCEPTOR_ADDRESSES", "").split(",")
  end
end
