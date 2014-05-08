module R
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

