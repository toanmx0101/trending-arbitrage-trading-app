user = User.create! :email => 'john@gmail.com', :password => 'topsecret', :password_confirmation => 'topsecret'
task_list = [
  {
    title: "Each must be able to create a task",
    description: "This task must have a title, a description, a date & time it was created and a date & time it should be completed.",
    is_completed: true,
    deadline: Time.parse("2023-03-09 12:00:00"),
    user_id: user.id
  },
  {
    title: "A user must be able to open a single task",
    description: "open a single task",
    is_completed: true,
    deadline: Time.parse("2023-03-09 12:00:00"),
    user_id: user.id
  },
  {
    title: "Edit task",
    description: "A user must be able to mark a task as completed",
    is_completed: true,
    deadline: Time.parse("2023-03-09 12:00:00"),
    user_id: user.id
  },
  {
    title: "Sorted, overdue, limit",
    description: "You must be able to see a view of all the tasks",
    is_completed: true,
    deadline: Time.parse("2023-03-09 12:00:00"),
    user_id: user.id
  },
  {
    title: "More filters for the list page",
    description: "More filters for the list page",
    is_completed: true,
    deadline: Time.parse("2023-03-09 12:00:00"),
    user_id: user.id
  },
  {
    title: "Apply tailwind design",
    description: "Apply tailwind design",
    is_completed: true,
    deadline: Time.parse("2023-03-09 12:00:00"),
    user_id: user.id
  },
  {
    title: "Text-search for the list page",
    description: "Text-search for the list page",
    is_completed: true,
    deadline: Time.parse("2023-03-09 12:00:00"),
    user_id: user.id
  },
  {
    title: "User-specific tasks with authentication",
    description: "User-specific tasks with authentication - [x]  User-specific tasks with authentication (users can be added via Rails console or directly into the database. No need to build an administrator account)",
    is_completed: true,
    deadline: Time.parse("2023-03-09 12:00:00"),
    user_id: user.id
  },
  {
    title: "Seed data",
    description: "Seed data",
    is_completed: true,
    deadline: Time.parse("2023-03-09 12:00:00"),
    user_id: user.id
  },
  {
    title: "Dockerize",
    description: "Dockerize",
    is_completed: true,
    deadline: Time.parse("2023-03-09 12:00:00"),
    user_id: user.id
  },
  {
    title: "Rubocop setup",
    description: "Rubocop setup",
    is_completed: true,
    deadline: Time.parse("2023-03-09 12:00:00"),
    user_id: user.id
  },
  {
    title: "Upload supporting files into the task",
    description: "Upload supporting files into the task",
    is_completed: false,
    deadline: Time.parse("2023-03-09 12:00:00"),
    user_id: user.id
  },
  {
    title: "Overdue task",
    description: "Overdue task description",
    is_completed: false,
    deadline: Time.parse("2023-01-01 12:00:00"),
    user_id: user.id
  },
]

task_list.each do |task|
  Task.create!(
    task
  )
end
Task.reindex
