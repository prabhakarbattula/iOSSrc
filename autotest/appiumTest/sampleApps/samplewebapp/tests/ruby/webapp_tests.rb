# run using:
#
# bundle exec rspec webapp_tests.rb
#

require 'rubygems'
require 'rspec'
require 'appium_lib'
require 'net/http'

RSpec.configure do |c|
  c.treat_symbols_as_metadata_keys_with_true_values = true
end

APP_PATH = '../../build/Release-iphonesimulator/samplewebapp.app'
SERVER_URL= 'http://127.0.0.1:4723/wd/hub'

# describe 'WebApp Tests' do
#   def caps
#       {
#         caps: {
#               #appiumVersion: "1.3.7",
#               platformName: "iOS",
#               #platformVersion: "8.2",
#               deviceName: "iPhone 6",
#               app: APP_PATH
#               #name: "Basic iOS Native Test",
#           },
#         appium_lib: {
#               sauce_username: nil, # don't run on sauce
#               sauce_access_key: nil,
#               wait: 10,
#           }
#       }
#   end
#
#   before do
#       @driver = Appium::Driver.new(caps)
#       @driver.start_driver
#       Appium.promote_appium_methods RSpec::Core::ExampleGroup
#   end
#
#   after do
#       @driver.driver_quit
#   end
#
#   describe 'Test Tab Bar' do
#     subject { find_elements(:class_name, 'UIATabBar')[0] }
#         it 'tab bar items exist' do
#           tabcount = subject.find_elements(:class_name, 'UIAButton')
#           tabcount.size.should eq 2
#         end
#
#         it 'Cycle between tabs' do
#           tabbutton = subject.find_elements(:class_name, 'UIAButton')[0]
#           wait{id('VideoWeb').click}
#           wait{id('WebView').click}
#           wait{id('VideoWeb').click}
#         end
#
#         it 'Click By Variable' do
#           VideoWebbutton = subject.find_elements(:class_name, 'UIAButton')[1]
#           WebViewbutton = subject.find_elements(:class_name, 'UIAButton')[1]
#           wait{VideoWebbutton.click}
#           wait{WebViewbutton.click}
#           wait{VideoWebbutton.click}
#         end
#
#         it 'Traverses Links' do
#           links = driver.find_elements(:class_name, 'UIALink') # UIALink
#           links.each do |link|
#             puts "Link:#{link.name}"
#           end
#           contexts = @driver.available_contexts
#           @driver.set_context(contexts[1])
#           driver.find_element(:name, 'English').click # UIALink
#         end
#         # it 'Tap 2nd Tab bar item' do
#         #   id('item 2').click
#         # end
#   end
# end

describe 'Test WebView with app caps' do
  def caps
      {
        caps: {
              #platformName: "Mac 10.8",
              deviceName: "iPhone 6",
              app: APP_PATH
          },
        appium_lib: {
              sauce_username: nil, # don't run on sauce
              sauce_access_key: nil,
              wait: 10,
          }
      }
  end

  before do
      @driver = Selenium::WebDriver.for(:remote, desired_capabilities:caps,url:SERVER_URL)
      #@driver.start_driver
      #Appium.promote_appium_methods RSpec::Core::ExampleGroup
  end

  after do
      @driver.quit
  end

   it 'Shows Available Contexts' do
    links = @driver.find_elements(:class_name, "UIALink") # UIALink
    links.each do |link|
      puts "Link Obj:#{link}"
      puts "Link Name:#{link.name}"
      if link.name == 'English'
        link.click
        Selenium::WebDriver::Wait.new(:timeout => 10)
      end
    end
    #id('Hae').text 'news' #UIAElement
  end
end
