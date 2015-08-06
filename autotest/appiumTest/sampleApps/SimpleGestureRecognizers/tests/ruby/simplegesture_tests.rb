# run using:
#
# bundle exec rspec simplegesture_tests.rb
#

require 'rubygems'
require 'rspec'
require 'appium_lib'
#require 'net/http'

# Required for 3.x before Rspec
# RSpec.configure do |c|
#   c.treat_symbols_as_metadata_keys_with_true_values = true
# end

APP_PATH = '../../build/Release-iphonesimulator/SimpleGestureRecognizers.app'

describe 'Gesture_Tests' do
  def caps
      {
        caps: {
              #appiumVersion: "1.3.7",
              platformName: "iOS",
              #platformVersion: "8.2",
              deviceName: "iPhone 6",
              app: APP_PATH
              #name: "Basic iOS Native Test",
          },
        appium_lib: {
              sauce_username: nil, # don't run on sauce
              sauce_access_key: nil,
              wait: 10,
          }
      }
  end

  before(:all) do
      @driver = Appium::Driver.new(caps)
      @driver.start_driver
      Appium.promote_appium_methods RSpec::Core::ExampleGroup
  end

  after(:all) do
      @driver.driver_quit
  end
    it 'Left Swipe' do
      #Left Swipe
      @driver.swipe(start_x: 300, end_x: 30, start_y: 50, end_y: 50, duration: 900).perform
      lbl = find_element(:class_name, 'UIAStaticText')
      expect(lbl.text).to eq 'Left Swipe'
    end
    it 'Right Swipe' do
      #Left Swipe
      @driver.swipe(start_x: 30, end_x: 300, start_y: 50, end_y: 50, duration: 900).perform
      lbl = find_element(:class_name, 'UIAStaticText')
      expect(lbl.text).to eq 'Left Swipe'
    end
    it 'Right Swipe' do
      #Left Swipe
      @driver.tap(start_x: 30, end_y: 50, duration: 900).perform
      lbl = find_element(:class_name, 'UIAStaticText')
      expect(lbl.text).to eq 'Left Swipe'
    end
end
