Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
      origins 'https://seabolt-react-rails-blog.herokuapp.com'
      resource '*',
        headers: :any,
        methods: :any
    end
  end