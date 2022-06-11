Given("a barman is signed up and confirmed as {string}, {string}, {string}, {string}") do |name, surname, email, password|
    Barman.create(name: name, surname: surname, email: email, password: password)
end

Given("I am a registered Barman as {string}, {string}, {string}, {string}") do |name, surname, email, password|
    Barman.create(name: name, surname: surname, email: email, password: password)
    visit new_barman_session_path
    fill_in 'barman_email', :with => email
    fill_in 'barman_password', :with => password
    click_button 'Login'
end

Given("I am a registered Barman as {string}, {string}, {string}, {string} who owns a Bar {string}, {string}, {string}, {string}") do |name, surname, email, password, barName, barAddr, barDesc, barTel|
    Barman.create(name: name, surname: surname, email: email, password: password)
    Bar.create(name: barName, address: barAddr, description: barDesc, tel: barTel)
end

When("a barman goes to the {string} page") do |page|
    visit page
end

Given("The barman {string} has a bar") do |email|
    @barman = Barman.find_by_email(email)
    @bar = Bar.create(name: "BarTest", description: "Descrizione test", tel: "0000000000", address: "Via del Test 45, Miragno")
    @barman.bars.push(@bar)
    @bar.barman_id = @barman.id
end

Given("I am a registered Barman as {string}, {string}, {string}, {string} and I have a Bar {string}, {string}, {string}, {string}") do |name, surname, email, password, barName, barAdd, barDesc, barTel|
    @barman = Barman.create(name: name, surname: surname, email: email, password: password)
    visit new_barman_session_path
    fill_in 'barman_email', :with => email
    fill_in 'barman_password', :with => password
    click_button 'Login'
    @bar = Bar.create(name: barName, address: barAdd, description: barDesc, tel: barTel, barman_id: @barman.id)
end 


Given("a Bar {string} of a Barman") do |bar|
    @barman = Barman.create(name: "prova", surname: "prova", email: "prova@prova.it", password: "prova123")
    @bar = Bar.create(name: bar, address: "Via della Prova", description: "Questa è una descrizione di prova", tel: "0000000000", barman_id: @barman.id)
end

Given("two Bars {string} and {string} of a Barman") do |bar1, bar2|
    @barman = Barman.create(name: "prova", surname: "prova", email: "prova@prova.it", password: "prova123")
    @bar1 = Bar.create(name: bar1, address: "Via della Prova", description: "Questa è una descrizione di prova", tel: "0000000000", barman_id: @barman.id)
    @bar2 = Bar.create(name: bar2, address: "Via della Prova", description: "Questa è una descrizione di prova", tel: "0000000000", barman_id: @barman.id)

end