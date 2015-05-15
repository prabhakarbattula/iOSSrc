#Reference : https://github.com/appium/ruby_lib/blob/893165dc1a869a2d240c054e13d26438728efb98/ios_tests/lib/common.rb
def back_click(opts = {})
  opts ||= {}
  search_wait = opts.fetch(:wait, 60 * 1.7)
  # iOS may have multiple 'back' buttons
  # select the first displayed? back button.
  wait(search_wait) do
    button_exact('Back').click
  end
end