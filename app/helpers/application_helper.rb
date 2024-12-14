module ApplicationHelper
    def breadcrumbs 
        links = []
        links << link_to("Home ", root_path, class: "text-blue-500 underline")

        case controller_name 
        when "dashboards"
            links << link_to("Dashboard ", dashboard_path, class: "text-gray-400 underline")
        when "products"
            links << link_to("Products ", products_path, class: "text-gray-400 underline")
            links << content_tag(:span, @product.name, class: "text-gray-500") if action_name == "show" && @product.present?
            links << content_tag(:span, "New", class: "text-gray-500") if action_name == "new"
            links << content_tag(:span, "Edit", class: "text-gray-500") if action_name == "edit"
        when "orders"
            links << link_to("Orders ", orders_path, class: "text-blue-500 underline")
            links << "New Order " if action_name == "new"
            links << "Order Details " if action_name == "show"
        end 

        safe_join(links, " > ".html_safe)
    end 

    def is_active?(name)
        controller_name == name
    end
end
