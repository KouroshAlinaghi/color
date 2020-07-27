module ColorHelper

  RGB = /^\((\d{1,2}|([01][0-9][0-9]|((25[0-5])|2[0-4]\d))),(| )(\d{1,2}|([01][0-9][0-9]|((25[0-5])|2[0-4]\d))),(| )(\d{1,2}|([01][0-9][0-9]|((25[0-5])|2[0-4]\d)))\)$/
  HEX = /^#(\d|[a-f])(\d|[a-f])(\d|[a-f])$/
  SIX_LENGTH_HEX = /^#(\d\d|\d[a-f]|[a-f]\d|[a-f][a-f])(\d\d|\d[a-f]|[a-f]\d|[a-f][a-f])(\d\d|\d[a-f]|[a-f]\d|[a-f][a-f])$/

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

  def ColorHelper.format(code, format)
    case format
    when :RGB
      rgb = code[1..(code.length-2)].split(/,/).map(&:strip).map(&:to_i)
      return rgb+["RGB"]
    when :SIX_LENGTH_HEX
      return [code[1..2].to_i(16), code[3..4].to_i(16), code[5..6].to_i(16), "six_length_hex"]
    when :HEX
      return [code[1].to_i(16), code[2].to_i(16), code[3].to_i(16), "Hex"]
    end
  end
end
