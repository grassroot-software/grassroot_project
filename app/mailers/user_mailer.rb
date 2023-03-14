class UserMailer < ApplicationMailer
  default from: 'The Grassroot Project <contact@thegrassrootproject.com>'

  def send_welcome_email_to(user)
    @user = user
    attachments.inline['logo.svg'] = logo_path

    mail(
      subject: 'Getting started with The Grassroot Project',
      to: user.email,
      template_name: 'welcome_email',
    )
  end

  private

  def logo_path
    Rails.root.join('app/assets/images/logo.svg').read
  end
end
