Given("I am a registered Drinker as {string}, {string}") do |email, password|
    Drinker.create(email: email, password: password)
    visit new_drinker_session_path
    fill_in 'drinker_email', :with => email
    fill_in 'drinker_password', :with => password
    click_button 'Login'
end

And("I am a registered Drinker as {string}, {string} correctly recognized in telegram") do |email, password|
    Drinker.create(email: email, password: password, chat_id: "0000")
    visit new_drinker_session_path
    fill_in 'drinker_email', :with => email
    fill_in 'drinker_password', :with => password
    click_button 'Login'
end 

Given("I am a registered Drinker as {string}, {string} correctly recognized in telegram and subscribed to the Bar {string}, {string}, {string}, {string}") do |email, password, barName, barAdd, barTel, barDesc|
    @drinker = Drinker.create(email: email, password: password, chat_id: "0000")
    visit new_drinker_session_path
    fill_in 'drinker_email', :with => email
    fill_in 'drinker_password', :with => password
    click_button 'Login'
    @bar = Bar.create(name: barName, address: barAdd, tel: barTel, description: barDesc)
    @barman = Barman.create(name: "prova", surname: "prova", email: "provaemail@email.com", password: "password")
    @bar.barman = @barman
    visit drinkers_personalArea_path
    select("Bar Prova", :from => "select-bar")
    click_button("Iscriviti!")
end 

Then("I should see the url to be {string}") do |page_name|
    current_path = URI.parse(current_url).path
    if current_path.respond_to? :should
      current_path.should == path_to(page_name)
    else
      assert_equal path_to(page_name), current_path
    end
  end