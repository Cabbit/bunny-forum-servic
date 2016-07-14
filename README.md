# Bunny Forum Service

## Setup(Mac OS)
Install docker for mac https://docs.docker.com/engine/installation/mac/ then run the following commands
* ```docker-compose build```
* ```docker-compose run app rake db:create```
* ```docker-compose run app rake db:migrate```

## Running Specs
```docker-compose run rake test```

## Before committing changes
```docker-compose run rake test``` Must pass
```docker-compose run rake rubocop``` Must pass

## Seeding the test database
```docker-compose run rake db:seed```

## Running the application
```docker-compose up```

## Creating new migrations
```run app bundle exec rake db:create_migration NAME=migration_name```

## Rebuilding database from scratch
```docker-compose run app rake db:drop && docker-compose run app rake db:create && docker-compose run app rake db:migrate```

## Endpoints

### GET /api/forums
```curl localhost:5000/api/forums```

### POST /api/forums
```curl -X POST -d 'forum[title]'='Discussion' -d 'forum[forum_type]'='category' -d 'forum[description]'='Discussions about the forum' localhost:5000/api/forums```

### GET /api/forums/:id
```curl localhost:5000/api/forums/1```

### PATCH /api/forums/:id
```curl -X PATCH -d 'forum[title]'='New Discussions' -d 'forum[forum_type]'='category' -d 'forum[description]'='Discussions about the forum' localhost:5000/api/forums/1```

### GET /api/topics
```curl localhost:5000/api/topics```

### POST /api/topics
```curl -X POST -d 'topic[title]'='Discussion' -d 'topic[forum_id]'='1' localhost:5000/api/topics```

### GET /api/posts
```curl localhost:5000/api/posts```

### POST /api/posts
```curl -X POST -d 'post[title]'='New Post Title' localhost:5000/api/posts```

### GET /api/posts/:id
```curl localhost:5000/api/posts/1```

### PATCH /api/posts/:id
```curl -X PATCH -d 'post[title]'='New Post Title' localhost:5000/api/posts/1```
