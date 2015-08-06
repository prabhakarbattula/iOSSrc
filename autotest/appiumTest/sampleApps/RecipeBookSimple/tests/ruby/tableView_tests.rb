# run using:
#
# bundle exec rspec u_i_catalog.rb
#

require 'rubygems'
require 'rspec'
require 'appium_lib'
require 'net/http'

RSpec.configure do |c|
  c.treat_symbols_as_metadata_keys_with_true_values = true
end

APP_PATH = './UICatalog.app.zip'

def desired_caps
  {
    caps: {
      platformName: 'iOS',
      deviceName:  'iPhone 6',
      versionNumber:  '8.1',
      app: APP_PATH
    },
    appium_lib: {
      sauce_username: nil, # don't run on sauce
      sauce_access_key: nil,
      wait: 10,
    }
  }
end

describe 'UI Catalog' do
  before(:all) do
    Appium::Driver.new(desired_caps).start_driver
    Appium.promote_appium_methods RSpec::Core::ExampleGroup
  end

  def back_click(opts={})
    opts        ||= {}
    search_wait = opts.fetch(:wait, 10) # seconds
    wait(search_wait) { button_exact('Back').click }
  end

  after(:all) do
    driver_quit
  end

  describe 'An Element', :one do
    subject { find_elements(:class_name, 'UIATableView')[0] }

    it { should_not be nil }

    context 'when used as a selection context' do
      it 'Can be a selection context' do
        rows = subject.find_elements(:class_name, 'UIATableCell')
        rows.size.should eq 3
      end
  end
end