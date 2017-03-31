describe 'Google' do

  class Google < Pages::BasePage
    url("http://google.com")
  end

  before(:all) do
    goto(Google)
  end

  it 'Google is reachable' do
    expect(on(Google).title).to eq "Google"
  end
end
