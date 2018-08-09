require "quick_login/engine"

module QuickLogin
  def quick_login_table(model, show_fields: [])
    return nil unless Rails.env.development?

    valid_model? model

    fields     = set_fields(model, show_fields)
    collection = model.all

    thead = set_thead(fields)
    tbody = set_tbody(collection, fields)
    table = content_tag(:table, thead.concat(tbody), class: 'table table-bordered')
    title = content_tag(:h3, 'Quick Login - This should only be present in Development environment')

    content_tag(:div, title.concat(table), style: 'display: inline-block;')
  end

  private

  def valid_model?(model)
    raise ArgumentError, "#{model} doesn't have devise installed." unless model.respond_to? :devise_modules
  end

  def valid_attribute?(resource, column)
    return true if column == :action

    raise ArgumentError, "#{column} is not an attribute of #{resource.class}." unless resource.respond_to? column
  end

  def set_fields(model, show_fields)
    klass_fields     = model.columns.map(&:name).map(&:to_sym)
    timestamp_fields = [:created_at, :updated_at]
    devise_fields    = [:encrypted_password, :reset_password_token,
                        :reset_password_sent_at, :remember_created_at,
                        :sign_in_count, :current_sign_in_ip, :last_sign_in_ip,
                        :current_sign_in_at, :last_sign_in_at]

    fields = klass_fields - timestamp_fields - devise_fields
    fields = show_fields.presence || fields
    fields + [:action]
  end

  def set_thead(fields)
    content_tag :thead do
      fields.collect do |field|
        concat content_tag(:th, field.capitalize)
      end.join.html_safe
    end
  end

  def set_tbody(collection, fields)
    content_tag :tbody do
      collection.collect do |resource|
        content_tag :tr do
          td_columns = fields.collect do |column|
            valid_attribute?(resource, column)

            if column == :action
              params = { "#{resource.class.to_s.underscore}" => { email: resource.email, password: 'password' } }
              concat content_tag(:td, button_to('Login', new_user_session_path, params: params))
            elsif column.to_s.include? '_id'
              value = resource.send(column.to_s.gsub('_id', '')).try(:name).presence || resource.send(column)
              concat content_tag(:td, value)
            elsif resource.send(column).respond_to? :attributes
              value = resource.send(column).try(:name).presence || resource.send(column)
              concat content_tag(:td, value)
            else
              concat content_tag(:td, resource.send(column))
            end
          end.join.to_s.html_safe
        end
      end.join.html_safe
    end
  end
end
