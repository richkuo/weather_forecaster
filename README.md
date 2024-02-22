### Weather Forecast Assessment
___

* Ruby version 3.2.3

* Rails version 7.1.3.2

* Production cache is configured to `:mem_cache_store`

* Weather API is from Open Weather, please obtain a free api key from https://openweathermap.org/api

* Using dotenv, https://github.com/bkeepers/dotenv

* Tests are built with RSpec, https://github.com/rspec/rspec-rails

___

* To get started, clone the project and run
```
bundle install
rake db:migrate
```

* Create a `.env` file and set
```
OPENWEATHER_API_KEY=YOUR_OPENWEATHER_API_KEY
```

* Start the local server with
```
rails s
```

* Run tests locally with
```
rspec
```
