# Courses demo API

## Тестовое задание:
Требуется создать прототип API-only приложения онлайн курсов. Заказчику требуется система, с реализованными сущностями:
- Курс
- Автор курса
- Компетенции, которые развивает данный курс

 API должно включать в себя CRUD операции для этих сущностей. Курс может содержать 0..n Компетенций. Автор может иметь 0..n Курсов. Курс должен иметь одного Автора. При удалении Автора, его курсам должен быть назначен другой.


Автор - в прототипе достаточно назначить его случайным образом.

### Технические требования
Для прототипа можно не делать авторизацию. API должно быть покрыто request- тестами с помощью rswag, и содержать сгенерированную этой библиотекой Swagger документацию к API приложения.

- Версия Ruby on Rails не ниже 6.0
- База данных PostgreSQL

### Definition of done
- Можно получить доступ к Swagger документации API и отправить тестовые запросы.
- Тесты проходят без ошибок и покрывают API
- Начальные данные можно установить командой bin/rails db:seed

---

# Локальное развертывание в Docker

Build image:

```bash
docker-compose build
```

Run seeds:

```bash
docker-compose run api bundle exec rails db:prepare
```

Start app on http://localhost:3000/api-docs

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

