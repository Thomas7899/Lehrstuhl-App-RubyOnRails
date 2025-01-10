# README

This README documents the steps necessary to set up and use the Lehrstuhl app, a comprehensive platform for managing various academic administrative tasks such as students, exams, seminars, final theses, and predoctoral fellows.

## Things you may want to cover:

### Ruby version

Specify the Ruby version required for this application. Example:
```
Ruby 3.4.1
```

### System dependencies

Ensure the following dependencies are installed on your system:
- PostgreSQL
- Redis (for caching and background jobs)
- Node.js (for frontend assets)
- Yarn (for JavaScript package management)

### Configuration

Set up environment variables for the application. You may use `.env` files to store these variables:
```
DATABASE_URL=your_database_url
REDIS_URL=your_redis_url
SECRET_KEY_BASE=your_secret_key_base
```

### Database creation

Run the following command to create the necessary databases:
```
bin/rails db:create
```

### Database initialization

Load the schema and seed the database with initial data:
```
bin/rails db:schema:load
bin/rails db:seed
```

### How to run the test suite

Run the tests to ensure the application is functioning correctly:
```
bin/rails test
```
Or, if using RSpec:
```
bundle exec rspec
```

### Services (job queues, cache servers, search engines, etc.)

- **Background Jobs:** Sidekiq is used for processing background jobs. Start it with:
  ```
  bundle exec sidekiq
  ```

- **Cache Server:** Ensure Redis is running for caching.

- **Search Engines:** If using Elasticsearch or similar, set up and configure the engine as necessary.

### Deployment instructions

1. Ensure all dependencies are installed on the server.
2. Set up environment variables as described in the Configuration section.
3. Deploy the application using Capistrano, Docker, or your preferred method.
4. Migrate the database:
   ```
   bin/rails db:migrate
   ```
5. Precompile assets:
   ```
   bin/rails assets:precompile
   ```
6. Restart the server.

---

For detailed documentation, refer to the [Lehrstuhl Wiki](#) or contact the support team.

