require_relative 'color_helper'

class Color

  include ColorHelper

  attr_reader :red, :green, :blue, :type
  def initialize(code) 
    hash = Color.convert_to_r_g_b(code)

    @code = code
    hash.each do |k, v|
      k == :type ? eval("@#{k} = :#{v.to_s}") : eval("@#{k} = #{v}")
    end
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

o = Color.new("(12, 12, 12,0.8)")
p o.to_s
