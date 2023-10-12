# frozen_string_literal: true

module HomeHelper
  def card_content(icon, title, content)
    render 'shared/card', icon:, title:, content:
  end
end
