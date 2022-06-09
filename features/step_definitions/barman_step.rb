Given("a barman is signed up and confirmed as {string}, {string}, {string}, {string}") do |name, surname, email, password|
    Barman.create(name: name, surname: surname, email: email, password: password)
end

Given("a registered Barman as {string}, {string}, {string}, {string}") do |name, surname, email, password|
    Barman.create(name: name, surname: surname, email: email, password: password)
    visit new_barman_session_path
    fill_in 'barman_email', :with => email
    fill_in 'barman_password', :with => password
    click_button 'Login'
end

Given("a registered Barman as {string}, {string}, {string}, {string} who owns a Bar {string}, {string}, {string}, {string}") do |name, surname, email, password, barName, barAddr, barDesc, barTel|
    Barman.create(name: name, surname: surname, email: email, password: password)
    Bar.create(name: barName, address: barAddr, description: barDesc, tel: barTel)
end

When("a barman goes to the {string} page") do |page|
    visit page
end

When("The barman {string} has a bar") do |email|
    @barman = Barman.find_by_email(email)
    @bar = Bar.create(name: "BarTest", description: "Descrizione test", tel: "0000000000", address: "Via del Test 45, Miragno")
    @barman.bars.push(@bar)
    @bar.barman_id = @barman.id
end