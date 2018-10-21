require 'rails_helper'

describe "Beerlist page" do
    before :all do
        Capybara.register_driver :selenium do |app|
          capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
            chromeOptions: { args: ['headless', 'disable-gpu']  }
          )
      
          Capybara::Selenium::Driver.new app,
            browser: :chrome,
            desired_capabilities: capabilities      
        end
        WebMock.disable_net_connect!(allow_localhost: true) 
      end

  before :each do
    @brewery1 = FactoryBot.create(:brewery, name:"Koff")
    @brewery2 = FactoryBot.create(:brewery, name:"Schlenkerla")
    @brewery3 = FactoryBot.create(:brewery, name:"Ayinger")
    @style1 = Style.create name:"Lager"
    @style2 = Style.create name:"Rauchbier"
    @style3 = Style.create name:"Weizen"
    @beer1 = FactoryBot.create(:beer, name:"Nikolai", brewery: @brewery1, style:@style1)
    @beer2 = FactoryBot.create(:beer, name:"Fastenbier", brewery:@brewery2, style:@style2)
    @beer3 = FactoryBot.create(:beer, name:"Lechte Weisse", brewery:@brewery3, style:@style3)
  end

  it "shows a known beer", :js => true do
    visit beerlist_path
    find('table').find('tr:nth-child(2)')
    expect(page).to have_content "Nikolai"
  end
  it "shows a beers in alphabetical order", :js => true do
    visit beerlist_path
    one = find('table').find('tr:nth-child(2)')
    expect(one).to have_content "Fastenbier"
    two = find('table').find('tr:nth-child(3)')
    expect(two).to have_content "Lechte Weisse"
    three = find('table').find('tr:nth-child(4)')
    expect(three).to have_content "Nikolai"
  end
  it "clicking style shows a beers ordered alphabetically by style", :js => true do
    visit beerlist_path
    click_on('style')
    one = find('table').find('tr:nth-child(2)')
    expect(one).to have_content "Nikolai"
    two = find('table').find('tr:nth-child(3)')
    expect(two).to have_content "Fastenbier"
    three = find('table').find('tr:nth-child(4)')
    expect(three).to have_content "Lechte Weisse"
  end
  it "clicking brewery shows a beers ordered alphabetically by brewery", :js => true do
    visit beerlist_path
    click_on('brewery')
    one = find('table').find('tr:nth-child(2)')
    expect(one).to have_content "Lechte Weisse"
    two = find('table').find('tr:nth-child(3)')
    expect(two).to have_content "Nikolai"
    three = find('table').find('tr:nth-child(4)')
    expect(three).to have_content "Fastenbier"
  end
end