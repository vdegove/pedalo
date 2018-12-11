module DeliveryHelper
  def delivery_tab_classes(period, selected_period)
    classes = ["tab"]
    classes << "active" if period == selected_period
    classes.join(' ')
  end

  def status_class(delivery)
    case delivery.status?
    when "Enregistré" then :enregistre
    when "Enlevé" then :enleve
    when "Livré" then :livre
    end
  end
end
