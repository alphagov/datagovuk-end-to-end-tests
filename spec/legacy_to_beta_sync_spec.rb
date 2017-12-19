require 'spec_helper'
require 'rest-client'

describe 'Legacy to Beta sync' do
  it 'Syncs a legacy dataset' do
    sync_url = ENV['SYNC_URL']
    create_legacy_dataset_url = 'https://test.data.gov.uk/api/3/action/package_create'
    time = Time.now.to_s
    time_formatted = time.to_s.gsub(/[^0-9a-z ]/i, '').split.join('-')
    title = "End to End Test Dataset #{time.to_s}"
    find_url = ENV['FIND_URL']

    legacy_payload = {
      'owner_org' => '90aefa0d-0e92-4895-a7fd-c1adb2b3f14f',
      'title' => title,
      'name' => "end-to-end-test-dataset-#{time_formatted}",
      'notes' => "My end to end test description #{time}",
      'license_id' => 'uk-ogl'
    }

    create_dataset_on_legacy(legacy_payload, create_legacy_dataset_url) 
    sync_dataset_on_beta(sync_url)

    visit(find_url)
    click_on('Sign in to beta.data.gov.uk')
    fill_in('q', with: time)
    click_on('Search Box Button')
    expect(page).to have_css('h2', title)
  end
end

def create_dataset_on_legacy(legacy_payload, create_legacy_dataset_url)
  RestClient::Request.execute(
    method: :post,
    url: create_legacy_dataset_url,
    headers: { 'X-CKAN-API-Key' =>  ENV['CKAN_API_KEY'] },
    payload: legacy_payload.to_json, 
    user: ENV['LEGACY_LOGIN_USERNAME'], 
    password: ENV['LEGACY_LOGIN_PASSWORD'],
    content_type: 'application/json',
    accept: 'application/json'
  )
end

def sync_dataset_on_beta(sync_url)
  RestClient::Request.execute(
    method: :get,
    url: sync_url,
    user: ENV['PUBLISH_BETA_BASIC_AUTH_USERNAME'],
    password: ENV['PUBLISH_BETA_BASIC_AUTH_PASSWORD']
  )
end
