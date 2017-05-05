web: bundle exec unicorn -p $PORT -c ./config/unicorn.rb
worker: bundle exec sidekiq -e production -c 3
clock: bundle exec clockwork config/clock.rb