require 'rails/generators/base'

module QuickLogin
  module Generators
    class InstallGenerator < Rails::Generators::Base
      class_option :routes, desc: 'Generate routes', type: :boolean, default: true

      def add_quick_login_routes
        quick_login_routes = "mount QuickLogin::Engine => '/quick_login'"
        route quick_login_routes
      end
    end
  end
end
