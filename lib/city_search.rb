require 'dawg'
module CitySearch
  extend self
  def search(q)
    results = dawg.query(q)
    results.map do |r|
      result = r.split(' ')
      code = result.last
      result.pop
      result = result + states[code.to_i]
    end
  end

  private

  def dawg
    @@dawg ||= Dawg.load(File.dirname(__FILE__) + '/../data/dawg.bin', :fast)
  end

  def states
    @@states ||= Marshal.load(File.read(File.dirname(__FILE__) + '/../data/state-countries.bin'))
  end

end
