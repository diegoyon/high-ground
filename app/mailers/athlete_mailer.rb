# frozen_string_literal: true

class AthleteMailer < ApplicationMailer
  default from: 'highgroundfitnesscompetition@gmail.com'

  def welcome_email
    @athlete = params[:athlete]
    attachments['descarga_de_responsabilidades.pdf'] = descarga_de_responsabilidades_file
    mail(to: @athlete.email, subject: "¡Bienvenido(a) a High Ground 2023 #{@athlete.first_name}!")
  end

  def information_email
    @athlete = params[:athlete]
    attachments['descarga_de_responsabilidades.pdf'] = descarga_de_responsabilidades_file
    attachments['horarios_sabado.pdf'] = horarios_sabado_file
    mail(to: @athlete.email, subject: 'Horarios sábado e información importante - High Ground 2023')
  end

  private

  def descarga_de_responsabilidades_file
    File.read('app/assets/email_attachments/descarga_de_responsabilidades.pdf')
  end

  def horarios_sabado_file
    File.read('app/assets/email_attachments/horarios_sabado.pdf')
  end
end
