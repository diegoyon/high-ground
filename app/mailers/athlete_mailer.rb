# frozen_string_literal: true

class AthleteMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def welcome_email
    @athlete = params[:athlete]
    attachments['descarga_de_responsabilidades.pdf'] = descarga_de_responsabilidades_file
    mail(bcc: @athlete.email, subject: 'Bienvenidos a High Ground 2023')
  end

  private

  def descarga_de_responsabilidades_file
    File.read('app/assets/email_attachments/descarga_de_responsabilidades.pdf')
  end
end
