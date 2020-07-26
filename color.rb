class Color
  attr_reader :red, :green, :blue, :type
  def initialize(code) 
    r_g_b_t = Color.convert_to_r_g_b(code)

    @code = code
    @red = r_g_b_t[0]
    @green = r_g_b_t[1]
    @blue = r_g_b_t[2]
    @type = r_g_b_t[3]
  end

  def component_to_hex(c) 
    hex = c.to_i.to_s(16)
    return hex.length == 1 ? "0" + hex : hex
  end

  def convert_to_hex()
    if @type == "RGB"
      "##{component_to_hex(@red)}#{component_to_hex(@green)}#{component_to_hex(@blue)}"
    else
      throw "Cannot Convert #{@type} to Hex"
    end
  end

  def to_s
    "Code: #{@code}, Type: #{@type}, Red: #{@red}, Green: #{@green}, Blue: #{@blue}"
  end

  def convert_to_rgb()
    if @type != "RGB"
      "(#{@red}, #{@green}, #{@blue})"
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
      rgb = code[1..(code.length-2)].split(/,/).map(&:strip).map(&:to_i)
      return rgb+["RGB"]
    when six_length_hex
      return [code[1..2].to_i(16), code[3..4].to_i(16), code[5..6].to_i(16), "six_length_hex"]
    when hex
      return [code[1].to_i(16), code[2].to_i(16), code[3].to_i(16), "Hex"]
    end
  end
end
