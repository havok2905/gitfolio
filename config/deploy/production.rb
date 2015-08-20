Dotenv.load

set :rails_env, 'production'

puts ENV['PROD_SERVER_ADDRESS']

server ENV['PROD_SERVER_ADDRESS'],
  user: ENV['PROD_SERVER_USER'],
  roles: %w(app db web),
  ssh_options: {
    user: ENV['PROD_SERVER_USERNAME'],
    password: ENV['PROD_SERVER_PASSWORD'],
    auth_methods: %w(publickey password),
    forward_agent: false
  }
