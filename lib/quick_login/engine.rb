module QuickLogin
  class Engine < ::Rails::Engine
    isolate_namespace QuickLogin

    initializer 'cocoon.initialize' do |app|
      ActiveSupport.on_load :action_view do
        ActionView::Base.send :include, QuickLogin::ViewHelpers
      end
    end
  end
end
