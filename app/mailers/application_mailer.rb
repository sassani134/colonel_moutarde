# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'thp.grenoble@gmail.com'
  layout 'mailer'
end
