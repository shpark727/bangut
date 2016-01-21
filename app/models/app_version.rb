class AppVersion < ActiveRecord::Base
    self.table_name = 'app_version'
    self.primary_key = :version_code

end
