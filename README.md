# Courses demo API


## QUICKSTART IN DOCKER

Build image:

```bash
docker-compose build
```

Run seeds:

```bash
docker-compose run api bundle exec rails db:seeds
```

Start app on http://localhost:3000 :

```bash
docker-compose up
```



Run tests:

```bash
docker-compose run --rm api bundle exec rspec
```

Run shell in new container:

```bash
docker-compose run --rm api bash
```

## API DOCUMENTATION

See documentation on http://localhost:3000/api-docs