require "quick_login/engine"

module QuickLogin
  def quick_login_table(users, show_fields: [])
    devise_fields = [:encrypted_password, :reset_password_token, 
                     :reset_password_sent_at, :remember_created_at, 
                     :sign_in_count, :current_sign_in_ip, :last_sign_in_ip,
                     :current_sign_in_at, :last_sign_in_at]

    return nil unless Rails.env.development?

    klass = users.first.class
    columns = klass.columns.map(&:name).map(&:to_sym) - [:created_at, :updated_at] - devise_fields
    columns = show_fields.presence || columns

    thead = content_tag :thead do
      columns.collect do |column|
        concat content_tag(:th, column)
      end.join.html_safe
    end

    tbody = content_tag :tbody do
      users.collect do |user|
        content_tag :tr do
          columns.collect do |column|
            concat content_tag(:td, user.send(column))
          end.to_s.html_safe
        end
      end.join.html_safe
    end

    table = content_tag(:table, thead.concat(tbody))
    title = content_tag(:h3, 'Quick Login')

    content_tag(:div, title.concat(table))
  end
end
