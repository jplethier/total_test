require_relative 'pages/support/page.rb'

Dir[Rails.root.join("spec/pages/support/*.rb")].each {|f| require f}
Dir[Rails.root.join("spec/pages/*.rb")].each {|f| require f}
