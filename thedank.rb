require 'yaml'
require 'active_support'
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
	response = cc.get_contact_by_email(email)
	@tacs = []
	response.results.each do |res|
	  @tacs << res
	end
	erb :thanks
end
