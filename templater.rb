require File.join(File.dirname(__FILE__), 'core_extensions.rb')

initialize_templater

required_recipes = %w(default jquery mongoid haml rspec factory_girl)
required_recipes.each {|required_recipe| apply recipe(required_recipe)}

run 'bundle install'

template_generators.each do |generator|
  generate generator
end

generators_configuration = <<-END
config.generators do |g|
  g.template_engine :haml
  g.fixture_replacement :factory_girl, :dir => 'spec/factories'
end
END

environment generators_configuration