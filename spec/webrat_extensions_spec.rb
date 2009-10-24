require File.dirname(__FILE__) + '/helper'
require 'webrat_extensions'

describe "Webrat Extensions" do
  describe "filling in a text field" do
    before do
      with_html <<-HTML
      <html>
        <input type="text" name="email" />
      </html>
      HTML

      fill_in "email", :with => "new value"
    end

    it "should update its element when its value is changed" do
      webrat.dom.to_s.should match('value="new value"')
    end
  end

  describe "selecting an option from a select list" do
    before do
      with_html <<-HTML
      <html>
        <select name="list">
          <option value="one" selected>One</option>
          <option value="two">Two</option>
        </select>
      </html>
      HTML

      select "Two", :from => "list"
    end

    it "should mark the option as selected when it is chosen" do
      webrat.dom.to_s.should match('value="two" selected')
    end

    it "should deselect the previously selected option" do
      webrat.dom.to_s.scan('selected').size.should == 1
    end
  end
end
