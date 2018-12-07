module DeliveryHelper
  def delivery_tab_classes(period, selected_period)
    classes = ["tab"]
    classes << "active" if period == selected_period
    classes.join(' ')
  end
end
