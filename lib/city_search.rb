require 'dawg'

class CitySearch
  def search(q, country = :all)
    results = selected_country(country).query(q)
    results.map do |r|
      result = r.split(' ')
      code = result.last
      result.pop
      result += states[code.to_i]
    end
  end

  private

  def selected_country(country = :all)
    case country
    when :russia
      russia
    else
      all
    end
  end

  def all
    @all ||= Dawg.load(File.dirname(__FILE__) + '/../data/all.bin')
  end

  def russia
    @russia ||= Dawg.load(File.dirname(__FILE__) + '/../data/russia.bin')
  end

  def states
    @states ||= Marshal.load(
      File.read(File.dirname(__FILE__) + '/../data/state-countries.bin')
    )
  end
end
