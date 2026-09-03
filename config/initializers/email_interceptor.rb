Rails.application.configure do
  if ENV.fetch("INTERCEPTOR_ADDRESSES", "").split(",").any?
    config.action_mailer.interceptors = %w[EmailInterceptor]
  end
end
