require 'pg'

class List

  attr_accessor(:name, :id)

  def initialize name
    @name = name
  end

  def id
    @id
  end

  def save
    results = DB.exec("INSERT INTO lists (name) VALUES ('#{@name}') RETURNING id;")
    @id = results.first['id'].to_i
  end

  def self.all
    results = DB.exec("SELECT * FROM lists;")
    lists = []
    results.each do |result|
      name = result['name']
      lists << List.new(name)
    end
    lists
  end

  def ==(another_list)
    self.name == another_list.name
  end

end
