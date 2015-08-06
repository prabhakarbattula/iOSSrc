# run using:
#
# bundle exec rspec tableView_tests.rb
#

require 'rubygems'
require 'rspec'
require 'appium_lib'
require 'net/http'

RSpec.configure do |c|
  c.treat_symbols_as_metadata_keys_with_true_values = true
end

APP_PATH = '../../build/Release-iphonesimulator/TableViewsAndCells.app'

# def desired_caps
#   {
#     caps: {
#       platformName: 'iOS',
#       deviceName:  'iPhone 6',
#       versionNumber:  '8.1',
#       app: APP_PATH
#     },
#     appium_lib: {
#       sauce_username: nil, # don't run on sauce
#       sauce_access_key: nil,
#       wait: 10,
#     }
#   }
# end

describe 'TableViewsAndCells' do
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

  def reorderCellsInTable(from, to)
    fromValid = execute_script("au.getElement(#{from.ref}).checkIsValid()")
    toValid = execute_script("au.getElement(#{to.ref}).checkIsValid()")
    if ( fromValid && toValid )
      fromElement = execute_script("au.getElement(#{from.ref})")
      toElement = execute_script("au.getElement(#{to.ref})")
        if ( !execute_script('"#{fromElement}".isVisible()') )
            execute_script(fromElement+'.scrollToVisible()')
            #put 1 second delay if needed
        end
        fromObjRectX = execute_script('fromElement.rect().origin.x')
        fromObjRectY = execute_script('fromElement.rect().origin.y')
        fromObjRectW = execute_script('fromElement.rect().size.width')
        fromObjRectH = execute_script('fromElement.rect().size.height')
        # setting drag point into the middle of the cell. You may need to change this point in order to drag an object from required point.
        sourceX = fromObjRectX + fromObjRectW - 10
        sourceY = fromObjRectY + fromObjRectH/2
        toObjRectX = execute_script("au.getElement(#{to.ref}.rect().origin.x")
        toObjRectY = execute_script("au.getElement(#{to.ref}.rect().origin.y")
        toObjRectW = execute_script("au.getElement(#{to.ref}.rect().size.width")
        toObjRectH = execute_script("au.getElement(#{to.ref}.rect().size.height")
        # setting drop point into the middle of the cell. The same as the drag point - you may meed to change the point to drop bellow or above the drop point
        destinationX = toObjRectX + toObjRectW - 10
        destinationY = toObjRectY + toObjRectH/2
        execute_script('UIATarget.localTarget().dragFromToForDuration({x:sourceX, y:sourceY}, {x:destinationX, y:destinationY}, 8)')
    end
  end

#
  def reorderCellsUsingEditButtons

    execute_script('UIATarget.localTarget().dragFromToForDuration(
      UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[0].cells()[0].buttons()[1].rect(),
      UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[0].cells()[1].buttons()[1].rect(),
      5)')

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

  describe 'Reorder TableView Cells' do
    it 'Using Edit Buttons' do
      id('Comets').click
      reorderCellsUsingEditButtons
    end

    it 'Using Cell locations' do
      id('Comets').click
      fromCell = ele_index('UIATableCell', 1)
      toCell = ele_index('UIATableCell',2)
      reorderCellsInTable(fromCell, toCell)
    end
  end
end
