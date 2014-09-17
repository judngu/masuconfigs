def require_dir(relative_dir_path)
  cleaned_relative_dir_path =relative_dir_path.sub(/\/$/, '')
  Dir["#{cleaned_relative_dir_path}/**/*.rb"].each do |file|
    puts "requiring #{file}"
    begin
      require file
    rescue Exception => e
      puts "Couldn't require #{file}: #{e.message}"
    end
  end
  return true
end

module R # for rails
  class Debug
    class << self

      def path(url_string, method='GET')
        puts "running: Rails.application.routes.recognize_path(\"#{url_string}\", {:method=>'#{method}'})"
        Rails.application.routes.recognize_path(url_string, {:method=>method})
      end
    end
  end
end
module RBM

  class Debug
    class << self
      def get_spawned_report_file(id)
        return SpawnedReport.find(id).binary_file.sha2_binary_path()
      end
    end

  end
end

def sql(myarg)
  ap ActiveRecord::Base.connection.execute(myarg).map{|x| x}
end

