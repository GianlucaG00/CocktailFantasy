Given("a registered Drinker as {string}, {string}") do |email, password|
    Drinker.create(email: email, password: password)
    visit new_drinker_session_path
    fill_in 'drinker_email', :with => email
    fill_in 'drinker_password', :with => password
    click_button 'Login'
end
