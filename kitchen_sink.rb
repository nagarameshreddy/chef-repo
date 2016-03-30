### Quick script to export Chef Server nodes and import them to Chef Compliance
### Save it as kitchen_sink.rb and run it like this:
# cd chef-repo
# cat kitchen_sink.rb | knife exec
require 'json'
require 'pry'

# This extracts data from the Chef Server. Auth done by `knife exec`
nodes_array = []
nodes.find('*:*') { |n|
  nodes_array << { id: n.name,
                    name: n.name,
                    hostname: n.name,
                    environment: n.environment,
                    loginUser: 'root',
                    loginMethod: 'ssh',
                    loginKey: 'admin/key1' }
}

puts "*** Successfully exported #{nodes_array.length} nodes from the Chef Server"

# This posts data to the Chef Compliance(tested against 0.9.6)
# !!!!!!!!!! Change these to fit your Chef Compliance !!!!!!!!!!!!
api_url = 'https://ap-chef-compliance.opschef.tv'
api_user = 'admin'
api_pass = 'admin'
uri = URI.parse(api_url)
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

# Get the API token first
request = Net::HTTP::Post.new('/api/oauth/token')
request.add_field('grant_type', 'client_credentials')
request.basic_auth api_user, api_pass
response = http.request(request)
response = JSON.parse(response.body)

# Post the nodes to the Compliance Server
request = Net::HTTP::Post.new("/api/owners/#{api_user}/nodes")
request.add_field('Content-Type', 'application/json')
request.basic_auth response['access_token'], ''
request.body = nodes_array.to_json
response = http.request(request)

if response.code == '200'
  puts '*** Successfully imported the nodes in Chef Compliance'
else
  puts "*** Failed to import, reason: #{response.body} code: #{response.code}"
end
