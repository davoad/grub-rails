if Rails.env.development? || Rails.env.test?
  begin
    require 'rubocop/rake_task'
    RuboCop::RakeTask.new(:rubocop) do |task|
      task.options = ['--display-cop-names']
    end
  rescue LoadError
    warn 'rubocop is not available.'
  end

  begin
    require 'cane/rake_task'

    desc 'Run cane to check quality metrics'
    Cane::RakeTask.new(:cane) do |cane|
      cane.abc_max = 15
      cane.no_style = true
      cane.abc_exclude = %w()
      cane.doc_exclude = ['**/*.rb']
    end
  rescue LoadError
    warn 'cane is not available.'
  end

  desc 'Code quality'
  task quality: [:cane, :rubocop]
end
