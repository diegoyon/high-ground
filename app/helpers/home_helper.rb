module HomeHelper
  def card_content(icon, title, content)
    render 'shared/card', icon: icon, title: title, content: content
  end
end
