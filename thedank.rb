require 'yaml'
require 'active_support'
require 'active_support/core_ext/object'
require 'sinatra'
require 'constantcontact'
set :views, settings.root + '/app/views'

get '/' do
	cc = ConstantContact::Api.new('99ez9k8gynjbwq88jhp8ch26','477141f1-c9d3-4adb-b0bc-b7a7fcea5331')
	erb :index
end

post '/' do
	cc = ConstantContact::Api.new('99ez9k8gynjbwq88jhp8ch26','477141f1-c9d3-4adb-b0bc-b7a7fcea5331')
	email = params[:email]
	
	@contact = {
	  'first_name' => nil,
	  'last_name' => nil
	}
	@email = {
	  'email_address' => email
	}
	@contact['email_addresses'] = []
	@contact['email_addresses'] << @email

	@list = {
		'id' => '1688731786'
	}
	@contact['lists'] = []
	@contact['lists'] << @list

	response = cc.get_contact_by_email(email)
	if !response.results.empty?
	  @tacs = []
	  response.results.each do |res|
	    @tacs << res
	  end
	else 
	  contact = ConstantContact::Components::Contact.create(@contact)
	  puts YAML::dump(contact)
	  cc.add_contact(contact)
	end
	erb :thanks
end
