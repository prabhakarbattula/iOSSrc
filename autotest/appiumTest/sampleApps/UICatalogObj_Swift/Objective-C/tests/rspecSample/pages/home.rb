# home.rb
module Pages
  module Home
    class << self
 
      def first_cell
        @found_cell = wait { text 2 }
        self
      end
 
      def title
        @found_cell.name
      end
 
      def click
        @found_cell.click
      end

      def back
      	back_click
      end 
    end
  end
end
 
module Kernel
  def home
    Pages::Home
  end
end