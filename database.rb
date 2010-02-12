ActiveRecord::Base.establish_connection(
        :adapter => "mysql",
        :host => "localhost",
        :username => "root",
        :password => "password",
        :database => "aurox"
)

class Relazs < ActiveRecord::Base
        has_many :animal
        belongs_to :user, :class_name => "Users"
        belongs_to :stalle, :class_name => "Stalles"
        belongs_to :ragsoc, :class_name => "Ragsocs"
        belongs_to :prop, :class_name => "Props"
        belongs_to :contatori, :class_name => "Contatoris"
end

class Stalles < ActiveRecord::Base
        has_many :relaz
end

class Ragsocs < ActiveRecord::Base
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
end

class Macellis < ActiveRecord::Base
        has_many :animal
        belongs_to :region, :class_name => "Regions"
end

class Trasportatoris < ActiveRecord::Base
        has_many :animal
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
