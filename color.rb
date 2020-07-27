require_relative 'color_helper'

class Color

  include ColorHelper

  attr_reader :red, :green, :blue, :type
  def initialize(code) 
    r_g_b_t = Color.convert_to_r_g_b(code)

    @code = code
    @red = r_g_b_t[0]
    @green = r_g_b_t[1]
    @blue = r_g_b_t[2]
    @type = r_g_b_t[3]
  end


  def self.convert_to_r_g_b(code)
    regex_constants = ColorHelper.constants
    for regex_const in regex_constants do
      if code =~ ColorHelper.const_get(regex_const)
        return ColorHelper.format(code, regex_const)
      end
    end
  end
end

o = Color.new("#12121e")
p o.to_s
