module ApplicationHelper
  def show_columns(resource)
    attributes = t("activerecord.attributes.#{controller.model.name.downcase}")
    unit = attributes[:unit].present? ? attributes[:unit] : {}

    content_tag(:div) do
      resource.attributes.slice(*controller.columns_of_show.map(&:to_s)).each do |k,v|
        concat( content_tag(:div) do
          "#{attributes[k.to_sym]} : #{v.is_a?(Float) ? v.round(2) : v} #{unit[k.to_sym] if v.present?}"
        end)
      end
    end
  end
end
