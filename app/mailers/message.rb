class Message < ActionMailer::Base
  default from: "musictripper@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.message.loadComplete.subject
  #
  def loadComplete(to, key)
    @key = key

    mail to: to
  end
end
