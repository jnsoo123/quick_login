module QuickLogin
  module ViewHelpers
    # This class creates the table for the user
    class TableRenderer
      include ActionView::Helpers
      include ActionView::Context

      # Initializes the object
      def initialize(model, options)
        @model   = model
        @options = options
        check_validity
      end

      # Renders the component
      def render
        content_tag(:div, title.concat(table), style: 'display: inline-block;')
      end

      private

      # Routes of logging in to devise controller
      def new_user_session_path
        Rails.application.routes.url_helpers.new_user_session_path
      end

      # Renders the title of the table
      def title
        content_tag(:h4, 'Quick Login - This should only be present in Development environment')
      end

      # Renders the table
      def table
        content_tag(:table, thead.concat(tbody), class: 'table table-bordered')
      end

      # Renders the thead of the table
      def thead
        content_tag :thead do
          fields.collect do |field|
            concat content_tag(:th, field.capitalize)
          end.join.html_safe
        end
      end

      # Renders the tbody of the table
      def tbody
        content_tag :tbody do
          collection.collect do |resource|
            tr_row resource
          end.join.html_safe
        end
      end

      # Renders the td of the table with attributes 
      def td_column(resource, field)
        case 
        when field == :action
          params = { "#{@model.to_s.underscore}" => { email: resource.email, password: 'password' } }
          concat content_tag(:td, button_to('Login', new_user_session_path, params: params))
        when field.to_s.include?('_id')
          value = resource.send(field.to_s.gsub('_id', '')).try(:name).presence || resource.send(field)
          concat content_tag(:td, value)
        when resource.send(field).respond_to?(:attributes)
          value = resource.send(field).try(:name).presence || resource.send(field)
          concat content_tag(:td, value)
        else
          concat content_tag(:td, resource.send(field))
        end
      end

      # Renders the tr of the table with resources
      def tr_row(resource)
        content_tag :tr do
          fields.collect do |field|
            td_column(resource, field)
          end.join.to_s.html_safe
        end
      end

      # Sets the collection of the model
      def collection
        @model.all
      end

      # Fetches the attributes of the model
      def model_attributes
        @model.columns.map(&:name).map(&:to_sym)
      end

      # Fetches the fields to be displayed except for 
      # devise fields like :encrypted_passwords, :reset_password_token,
      # etc. and timestamp fields like :created_at and :updated_at
      def fields
        timestamp_fields = [:created_at, :updated_at]
        devise_fields    = [:encrypted_password, :reset_password_token,
                            :reset_password_sent_at, :remember_created_at,
                            :sign_in_count, :current_sign_in_ip, :last_sign_in_ip,
                            :current_sign_in_at, :last_sign_in_at]

        field_value = model_attributes - timestamp_fields - devise_fields
        field_value = @options[:fields].presence || field_value

        # :action is for the login button
        field_value + [:action]
      end

      # Checks validity of the arguments
      def check_validity
        raise ArgumentError, "#{@model} doesn't have devise installed" unless @model.respond_to? :devise_modules

        return unless @options[:fields].present?

        raise ArgumentError, ":fields option should be an array of attributes" unless @options[:fields].is_a? Array

        @options[:fields].each do |field|
          raise ArgumentError, ":#{field} is not an attribute of #{@model}" unless valid_attribute? field
        end
      end

      # To check the validity of the attributes
      def valid_attribute?(field)
        model_attributes.include?(field) || field != :action
      end

      # Overrides protect_against_forgery? method from view helpers
      def protect_against_forgery?
        false
      end
    end
  end
end
