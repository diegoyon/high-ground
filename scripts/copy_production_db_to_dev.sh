rails db:environment:set RAILS_ENV=development
rails db:drop
# RAILS_ENV=test rails db:create
heroku pg:pull DATABASE_URL high_ground_development -a high-ground
