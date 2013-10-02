require 'sass'

module Sass::Script::Functions
  def getRandomColor(as_str = true)
    if as_str
      Sass::Script::String.new("#%06x" % (rand * 0xffffff))
    else
      Sass::Script::Color.new([rand(255), rand(255), rand(255)])
    end
  end
end