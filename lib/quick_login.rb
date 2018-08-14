require 'quick_login/engine'
require 'quick_login/view_helpers/table_renderer'

module QuickLogin
  module ViewHelpers
    def quick_login_table(model, options = {})
      return nil unless Rails.env.development?

      renderer = TableRenderer.new(model, options)
      renderer.render
    end
  end
end
