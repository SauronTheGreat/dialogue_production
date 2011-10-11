# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def checklist(name, collection, value_method, display_method, selected)
    selected ||= []

    ERB.new(%{
    <div class="checklist" style="border:1px solid #666; width:100%; height:50%; overflow:auto">
      <% for item in collection %>
        <%= check_box_tag name, item.send(value_method), selected.include?(item.send(value_method)) %>
        <%=h item.send(display_method) %><br />
      <% end %>
    </div>}).result(binding)
  end

  def sortable(column, title=nil)
    title ||=column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil 
    direction = column ==sort_column && sort_direction == "asc" ? "desc" :"asc"
    link_to title, {:sort=> column, :direction => direction}, {:class=> css_class}
  end
end
