tasks = Dir[File.expand_path('../*.rake', __FILE__)].delete_if do |task_file|
  task_file =~ /vedeu\.rake$/
end

tasks.each { |task_file| load task_file }
