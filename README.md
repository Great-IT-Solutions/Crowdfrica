![setup](https://user-images.githubusercontent.com/2026648/158160702-6631564c-beb7-45af-b50d-ab5ecbacb733.png)
# Crowdfrica

[![Maintainability](https://api.codeclimate.com/v1/badges/7af3f345001f8e6a2810/maintainability)](https://codeclimate.com/repos/5eece9e08886946313003390/maintainability) [![Test Coverage](https://api.codeclimate.com/v1/badges/7af3f345001f8e6a2810/test_coverage)](https://codeclimate.com/repos/5eece9e08886946313003390/test_coverage)

## Development Guidelines
### Docker


Build app image:
```sh
make build
```

When running the app for the first time, create, migrate and seed the database with the command:
```sh
make db.setup
```

Run the app:
```sh
make up
```

Stop the app:
```sh
make down
```

### How to make a feature request PR

TODO

### Running the test suite

The entire test suite is run using the command:
```sh
bundle exec rspec spec
```

### Feature specs

The feature specs are run using either chrome (those tagged with `js: true`) for javascript dependent tests or the [rack test driver](https://github.com/teamcapybara/capybara#selecting-the-driver) for all others.

For debugging non-js specs, you can view an unstyled page in a browser by adding the command `save_and_open_page` to the test.

### RuboCop

To ensure a consistent style we use [RuboCop](https://docs.rubocop.org/en/stable/). To check for violations on changes you make, you can either user a code editor plugin ([sublime](https://packagecontrol.io/packages/RuboCop)/[VSCode](https://marketplace.visualstudio.com/items?itemName=misogi.ruby-rubocop)) or run the command:
```sh
bundle exec rubocop {file1} {file2}
```

See the [Ruby Style Guide](https://rubystyle.guide/), [Rails Style Guide](https://rails.rubystyle.guide/) and [RSpec Style Guide](https://rspec.rubystyle.guide/).

If you correct a number of existing violations (and please do 🙇‍♀️), it may be best to add these corrections in a second commit to make your pull request easier to review.
