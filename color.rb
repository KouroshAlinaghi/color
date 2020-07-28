require_relative 'color_helper'

class Color

  include ColorHelper

  def initialize(code) 
    hash = Color.convert_to_r_g_b(code)
    instance_variables = hash.keys+[:code]

    str = "Color.attr_reader"
    for instance_var in instance_variables 
      str += " :#{instance_var.to_s},"
    end
    str = str[0..str.length-2]
    eval str

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

o = Color.new("rgba(085, 100, 0, 0.3)")
p o.to_s
