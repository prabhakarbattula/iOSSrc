#spec_helper.rb

require 'rspec'
require 'appium_lib'

def setup_driver
	return if $driver
	appium_txt = File.join(Dir.pwd, 'appium.txt')
    caps = Appium.load_appium_txt file: appium_txt
    Appium::Driver.new caps
end

def promote_methods
    Appium.promote_appium_methods RSpec::Core::ExampleGroup
    Appium.promote_singleton_appium_methods Pages
end

setup_driver
promote_methods

RSpec.configure do |config|

	config.before(:each) do
		$driver .start_driver
	end

	config.after(:each) do
		driver_quit
	end
end