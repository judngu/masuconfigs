module R
  class Debug
    class << self
      def get_url_handlers(url, options = {:method=>'GET'})
        return Rails.application.routes.recognize_path(url, options)
      end
    end
    def help
      puts "R::Debug methods: "
      puts "get_url_handlers(url, options= {:method=>'GET'})"
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
