#ActiveRecord::Base.logger = Logger.new(STDOUT) #Butta in console il codice sql delle varie operazioni e query
ActiveRecord::Base.establish_connection(
        :adapter => "mysql",
        :host => "localhost",
        :username => "root",
        :password => "new-password",
        :database => "aurox"
)

class Relazs < ActiveRecord::Base
        has_many :animal
        has_many :mod4temp
        belongs_to :user, :class_name => "Users"
        belongs_to :stalle, :class_name => "Stalles"
        belongs_to :ragsoc, :class_name => "Ragsocs"
        belongs_to :detentori, :class_name => "Detentoris"
        belongs_to :prop, :class_name => "Props"
        belongs_to :contatori, :class_name => "Contatoris"
end

class Stalles < ActiveRecord::Base
        has_many :relaz
        belongs_to :region, :class_name => "Regions"
end

class Ragsocs < ActiveRecord::Base
        has_many :relaz
end

class Detentoris < ActiveRecord::Base
        has_many :relaz
end

class Props < ActiveRecord::Base
        has_many :relaz
end

class Razzas < ActiveRecord::Base
        has_many :animal
end

class Animals < ActiveRecord::Base
        belongs_to :relaz, :class_name => "Relazs"
        belongs_to :razza, :class_name => "Razzas"
        belongs_to :allevamenti, :class_name => "Allevamentis"
        belongs_to :allevamentiusc, :class_name => "Allevamentiuscs"
        belongs_to :macelli, :class_name => "Macellis"
end

class Uscites < ActiveRecord::Base
        has_many :animal
end

class Ingressos < ActiveRecord::Base
        has_many :animal
end

class Nations < ActiveRecord::Base
        has_many :animal
end

class Allevamentis < ActiveRecord::Base
        has_many :animal
        has_many :mod4temp
end

class Macellis < ActiveRecord::Base
        has_many :animal
        has_many :mod4temp
        belongs_to :region, :class_name => "Regions"
end

class Trasportatoris < ActiveRecord::Base
        has_many :animal
        #has_many :mod4temp
end

class Luncampis < ActiveRecord::Base
end    

class Contatoris < ActiveRecord::Base
        has_many :relazs
end

class Registros < ActiveRecord::Base
        has_many :relazs
end

class Regions < ActiveRecord::Base
        has_many :macelli
end
class Mod4temps < ActiveRecord::Base
        belongs_to :relaz, :class_name => "Relazs"
        belongs_to :allevamenti, :class_name => "Allevamentis"
        belongs_to :macelli, :class_name => "Macellis"
        #belongs_to :trasportatori, :class_name => "Trasportatoris"
end
