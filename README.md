# treestats.net-next

Re-write of [treestats.net](https://treestats.net).

## Running

1. `bundle`
2. `bundle exec rake db:migrate`
3. Optional. `bundle exec rake db:seed` to add seed (test) data.

## Testing

Run `bundle exec rake test`.

## Development

- JavaScript dependencies must be manually updated with `npm run copy`.
  This copies installed dependencies into `./assets/javascripts`.
- To update dependencies, run `npm update` first.
