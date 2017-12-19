require 'spec_helper'

describe 'Something' do
  it 'does something cool' do
    # This does not work - you get a 301 redirect
    # visit('http://test-user:nefPvbyVKJPzu9mnX8gVCzd3HZv6U8@test.data.gov.uk')

    # This works ok 
    # visit('http://publisher@example.com:gnocchi@publish-data-beta-staging.cloudapps.digital')
    description = 'My test description'
    summary = 'My test summary'
    location = 'London'
    # publish_url = ENV['PUBLISH_URL'] 
    # find_url = ENV['FIND_URL']

    publish_url = 'http://localhost:3000' 
    find_url = 'http://localhost:4000'
    date = Time.now 
    title = "My test dataset #{date}" 

    # Home 
    visit(publish_url)
    expect(page).to have_css('h1', 'Publish and update data for your organisation')

    # Login
    click_on('Sign in')
    expect(page).to have_css('h1', 'Sign in')
    fill_in('user_email', with: ENV['PUBLISH_BETA_LOGIN_USERNAME'])
    fill_in('Password', with: ENV['PUBLISH_BETA_LOGIN_PASSWORD'])
    click_button 'Sign in'

    # Create new dataset
    click_link('Manage datasets')
    click_link('Create a dataset')
    fill_in('dataset[title]', with: title)
    fill_in('dataset[summary]', with: summary)
    fill_in('dataset[description]', with: description)
    click_button('Save and continue')

    # Licence
    choose('id_licence_uk-ogl', visible: false)
    click_button('Save and continue')

    # Location
    fill_in('dataset[location1]', with: location)
    click_button('Save and continue')

    # Frequency
    choose('id_frequency_never', visible: false)
    click_button('Save and continue')

    # Add Datafile
    fill_in('link[url]', with: 'https://www.google.com')
    fill_in('link[name]', with: 'my test datafile')
    click_button('Save and continue')

    # Files page
    expect(page).to have_content('Links to your data')
    expect(page).to have_content('my test datafile')
    click_link('Save and continue')

    # Add Documents
    fill_in('doc[url]', with: 'https://www.google.com')
    fill_in('doc[name]', with: 'my test doc')
    click_button('Save and continue')

    # Documents page
    expect(page).to have_content('Links to supporting documents')
    expect(page).to have_content('my test doc')
    click_link('Save and continue')

    # Publish Page
    expect(page).to have_css('li', 'Status: draft')
    expect(page).to have_content(title)
    expect(page).to have_content(summary)
    expect(page).to have_content(description)
    expect(page).to have_content('Open Government Licence')
    expect(page).to have_content(location)
    expect(page).to have_content('One-off')

    click_button('Publish')

    expect(page).to have_content('Your dataset has been published')

    # Find the dataset 
    visit(find_url)
    click_on('Sign in to beta.data.gov.uk')
    fill_in('q', with: title)
    click_on('Search Box Button')
    expect(page).to have_css('h2', title)
    click_on(title)
    expect(page).to have_css('h2', title)
    expect(page).to have_content(summary)
  end
end
