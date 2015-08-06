# run using:
#
# bundle exec rspec busticker_test.rb
#

require 'rubygems'
require 'rspec'
require 'appium_lib'
#require 'net/http'

# RSpec.configure do |c|
#   c.treat_symbols_as_metadata_keys_with_true_values = true
# end

APP_PATH = '../../build/Build/Products/Release-iphonesimulator/busticker.app'

describe 'Busticker_Test' do
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

  def back_click(opts={})
    opts        ||= {}
    search_wait = opts.fetch(:wait, 10) # seconds
    wait(search_wait) { button_exact('Back').click }
  end

  describe 'BusTicker' do
  #  subject {find_elements(:class_name, 'UIATabBar')[0]}
  # tabBar =  find_elements(:class_name, 'UIATabBar')[0]
  # buttons = tabBar.find_elements(:class_name, 'UIAButton')
    it 'when 3 tabs exist' do
       tabBar =  find_elements(:class_name, 'UIATabBar')[0]
       buttons = tabBar.find_elements(:class_name, 'UIAButton')
      expect(buttons.size).to eq 3
    end

    it 'when tab names match' do
      tabBar =  find_elements(:class_name, 'UIATabBar')[0]
      buttons = tabBar.find_elements(:class_name, 'UIAButton')
      buttonNames = []
      buttons.each do |button|
        buttonNames.unshift(button.label)
      end
      tabNames = ["Line", "Search", "Home"]
      expect(tabNames).to match_array(buttonNames)
    end

    it 'when Line tab is active' do
      tabBar =  find_elements(:class_name, 'UIATabBar')[0]
      buttons = tabBar.find_elements(:class_name, 'UIAButton')
      expect(buttons[0].value).to eq 1
    end

    it 'when search is active' do
      tabBar =  find_elements(:class_name, 'UIATabBar')[0]
      buttons = tabBar.find_elements(:class_name, 'UIAButton')
      buttons[1].click
      buttons = tabBar.find_elements(:class_name, 'UIAButton')
      expect(buttons[1].value).to eq 1
    end

    it 'when hervanta searched' do
      first_button.click
      searchb = find_element(:class_name,'UIASearchBar')
      searchb.send_keys 'hervanta'
      btns = find_elements(:class_name,'UIAButton')
      wait{btns[7].click} # 7th button is search button
      tbl = find_elements(:class_name, 'UIATableView')
      cells = tbl[0].find_elements(:class_name, 'UIATableCell')
      cells[0].click # Selecting First Row Containing "Hervantakeskus"
      expect(exists{textfield_exact('Hervantakeskus')}).to be true
    end
  end

end
