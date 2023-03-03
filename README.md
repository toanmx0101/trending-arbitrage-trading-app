# Todolist

At BoardPackager, we have decided to provide our team with a customized task list, so that they can create and manage the tasks they will need to complete over the coming days and weeks.

**NOTE - For this project, please ensure all the numbered items are finished**

We’ve determined that this website would need the following functionalities:

1. Each must be able to create a task
    - [x]  This task must have a title, a description, a date & time it was created and a date & time it should be completed.
2. A user must be able to open a single task
    - [x]  open single task
3. A user must be able to mark a task as completed
    - [x]  mark task as completed
4. A user must be able to edit the title, description and date-to-complete a task
    - [x]  Edit task
5. A user must be able to delete a task
    - [x]  Delete task
6. You must be able to see a view of all the tasks
    - [x]  Sorted in ascending order by when they must be completed
    - [x]  Tasks that are overdue need to be marked as such
    - [x]  There should be a way to limit to just tasks that are due by the end of today

### Extra Items:

- [ ]  Upload supporting files into the task
- [x]  More filters for the list page.
    - [x]  sort option/order
    - [x]  Due today sort
    - [x]  items per page
- [x]  Apply tailwind design
- [x]  Text-search for the list page
- [x]  User-specific tasks with authentication (users can be added via Rails console or directly into the database. No need to build an administrator account)
- [x]  Dockerize
- [x]  Seed data
- [x]  Rubocop setup


### Techs
- Ruby on Rails
- Elasticsearch for full-text search
- Tailwind CSS
- SQL Lite
- ChatGPT for refactor code
- Docker

### FIXME
- Downtime of task count on index pages

### Todos
- Upload supporting files into the task

### First setup

```
docker-compose exec web rails db:migrate

# Optional
docker-compose exec web rails db:seed
```


### Test account

john@gmail.com / topsecret
