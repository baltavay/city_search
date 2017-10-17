require 'dawg'
module CitySearch
  extend self
  def search(q)
    states = Marshal.load(File.read('../state-countries.bin'))
    dawg = Dawg.load('../data/dawg.bin', :fast)
    dawg.query(q)
  end
end
