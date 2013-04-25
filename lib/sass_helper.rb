require 'sass'

module Sass::Script::Functions
  # FONTS = ["Lobster", "Raleway","Lato","Oleo Script","Special Elite","Fredoka One"]
  FONTS = ["Times New Roman", "Arial", "Helvetica", "sans-serif", "serif", "Garamond", "Cambria", "Calibri", "Georgia"]
  PATTERNS = ["img/bg_stripe.png", "img/bg_square.png"]
  font = nil

  def getRandomColor(as_str = true)
    if as_str
     Sass::Script::String.new("#%06x" % (rand * 0xffffff))
   else
     Sass::Script::Color.new([rand(255), rand(255), rand(255)])
   end
  end

  def getRandomFont
    font ||= FONTS.sample()
    Sass::Script::String.new(font)
  end

  def getRandomPattern
    pattern ||= PATTERNS.sample()
    Sass::Script::String.new(pattern)
  end

  # Refactor these! Maybe define a random uniform function with a scaling parameter.
  def getRandomH1Size
    r = Random.new
    rpx ||= r.rand(40...60)
    Sass::Script::String.new(rpx.to_s + "px")
  end

  def getRandomMapHeight
    r = Random.new
    rpx ||= r.rand(200...1400)
    Sass::Script::String.new(rpx.to_s + "px")
  end

  def getRandomBorderRadius
    r = Random.new
    rpx ||= r.rand(0...50)
    Sass::Script::String.new(rpx.to_s + "px")
  end
end
