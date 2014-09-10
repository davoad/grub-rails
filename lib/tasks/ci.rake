desc 'Continuous integration build'
task ci: [:environment, :db_drop_create_migrate, :quality, :spec]

Rake::Task['default'].clear if Rake::Task.tasks.map(&:name).include?('default')
task default: :ci

task db_drop_create_migrate: [:'db:drop', :'db:create', 'db:migrate']
