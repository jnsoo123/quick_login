require "quick_login/engine"

module QuickLogin
  def quick_login_table(model, show_fields: [])
    return nil unless Rails.env.development?
    return nil unless model.respond_to? :devise_modules

    klass_fields     = model.columns.map(&:name).map(&:to_sym)
    timestamp_fields = [:created_at, :updated_at]
    devise_fields    = [:encrypted_password, :reset_password_token,
                        :reset_password_sent_at, :remember_created_at,
                        :sign_in_count, :current_sign_in_ip, :last_sign_in_ip,
                        :current_sign_in_at, :last_sign_in_at]

    columns = klass_fields - timestamp_fields - devise_fields
    columns = show_fields.presence || columns
    columns = columns + [:action]

    users = model.all

    thead = content_tag :thead do
      columns.collect do |column|
        concat content_tag(:th, column.capitalize)
      end.join.html_safe
    end

    tbody = content_tag :tbody do
      users.collect do |user|
        content_tag :tr do
          td_columns = columns.collect do |column|
            if column == :action
              user_params = { user: { email: user.email, password: 'password' } }
              concat content_tag(:td, button_to('Login', new_user_session_path, params: user_params))
            else
              concat content_tag(:td, user.send(column))
            end
          end.join.to_s.html_safe
        end
      end.join.html_safe
    end

    table = content_tag(:table, thead.concat(tbody), class: 'table table-bordered')
    title = content_tag(:h3, 'Quick Login - This should only be present in Development environment')

    content_tag(:div, title.concat(table))
  end
end
