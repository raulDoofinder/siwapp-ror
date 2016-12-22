require "rails_helper"

feature "Taxes:" do

  background do
    @tax = FactoryGirl.create(:tax)
  end

  scenario "User can update a tax", :js => true, :driver => :webkit do
    visit "/taxes/1/edit"

    fill_in "Name", with: "VAT 18%"
    fill_in "Value", with: "18"
    check "Enabled"

    click_on "Save"

    expect(page.current_path).to eql(taxes_path)
    expect(page).to have_content("Tax was successfully updated")
  end

  scenario "User can't update a tax with invalid data", :js => true, :driver => :webkit do
    visit "/taxes/1/edit"

    fill_in "Value", with: "dieciocho"

    click_on "Save"

    expect(page.current_path).to eql(tax_path(@tax))
    # Webkit only allows numbers for numeric fields so probably the field
    # couldn't be changed to hold "dieciocho" as its value. In that case
    # we get 2 errors instead of 1.
    expect(page).to have_content("2 errors")
  end

end
