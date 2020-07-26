class Color
  attr_reader :red, :green, :blue, :type
  def initialize(code) 
    r_g_b_t = Color.convert_to_r_g_b(code)

    @red = r_g_b_t[0]
    @green = r_g_b_t[1]
    @blue = r_g_b_t[2]
    @type = r_g_b_t[3]
  end

  def component_to_hex(c) 
    hex = c.to_i.to_s(16)
    return hex.length == 1 ? "0" + hex : hex
  end

  def component_to_rgb(c)
    c.to_i(16)
  end

  def convert_to_hex()
    if @type == "RGB"
      "##{component_to_hex(@red)}#{component_to_hex(@green)}#{component_to_hex(@blue)}"
    else
      throw "Cannot Convert #{@type} to Hex"
    end
  end

  def to_s
    if @type == "RGB"
      "(#{@red}, #{@green}, #{@blue})"
    else
      "##{@red}#{green}#{blue}"
    end
  end

  def convert_to_rgb()
    if @type != "RGB"
      "(#{component_to_rgb(@red)}, #{component_to_rgb(@green)}, #{component_to_rgb(@blue)})"
    else
      throw "Cannot Convert #{@type} to RGB"
    end
  end

  def self.convert_to_r_g_b(code)
    rgb = /^\((\d{1,2}|([01][0-9][0-9]|((25[0-5])|2[0-4]\d))),(| )(\d{1,2}|([01][0-9][0-9]|((25[0-5])|2[0-4]\d))),(| )(\d{1,2}|([01][0-9][0-9]|((25[0-5])|2[0-4]\d)))\)$/
    hex = /^#(\d|[a-f])(\d|[a-f])(\d|[a-f])$/
    six_length_hex = /^#(\d\d|\d[a-f]|[a-f]\d|[a-f][a-f])(\d\d|\d[a-f]|[a-f]\d|[a-f][a-f])(\d\d|\d[a-f]|[a-f]\d|[a-f][a-f])$/

    case code
    when rgb
      rgb = code[1..(code.length-2)].split(/,/).map(&:strip)
      return rgb+["RGB"]
    when six_length_hex
      return [code[1..2], code[3..4], code[5..6], "six_length_hex"]
    when hex
      return [code[1], code[2], code[3], "Hex"]
    end
  end
end
rgb = Color.new("(001,234,255)")
p rgb.red # => "001"
p rgb.green # => "234"
p rgb.blue # => "255"
p rgb.to_s # => "(001, 234, 255)"
