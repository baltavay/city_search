require 'dawg'

class CitySearch
  def initialize(country = :all)
    raise 'country not found' unless country_exists?(country)

    @country = country
  end

  def search(q)
    results = db.query(q).reject {|r| r.empty? }
    results.map do |r|
      result = r.split(' ')
      code = result.last
      result.pop
      result += states[code.to_i]
    end
  end

  def country_exists?(country)
    File.exists?(File.dirname(__FILE__) + "/../data/#{country}.bin")
  end

  def db
    @all ||= Dawg.load(File.dirname(__FILE__) + "/../data/#{@country}.bin")
  end

  def states
    @states ||= Marshal.load(
      File.read(File.dirname(__FILE__) + "/../data/#{@country}_states.bin")
    )
  end
end
