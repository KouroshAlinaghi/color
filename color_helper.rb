module ColorHelper

  RGB = /^rgb\((\d{1,2}|([01][0-9][0-9]|((25[0-5])|2[0-4]\d))),(| )(\d{1,2}|([01][0-9][0-9]|((25[0-5])|2[0-4]\d))),(| )(\d{1,2}|([01][0-9][0-9]|((25[0-5])|2[0-4]\d)))\)$/i
  RGBA = /^rgba\((\d{1,2}|([01][0-9][0-9]|((25[0-5])|2[0-4]\d))),(| )(\d{1,2}|([01][0-9][0-9]|((25[0-5])|2[0-4]\d))),(| )(\d{1,2}|([01][0-9][0-9]|((25[0-5])|2[0-4]\d)))(,|, )(0|1|0.\d|1.0)\)$/i
  HEXA = /^#(\d|[a-f])(\d|[a-f])(\d|[a-f])(|(\d|[a-f]))$/i
  HEX = /^#(\d|[a-f])(\d|[a-f])(\d|[a-f])$/i
  HHEEXX = /^#(\d\d|\d[a-f]|[a-f]\d|[a-f][a-f])(\d\d|\d[a-f]|[a-f]\d|[a-f][a-f])(\d\d|\d[a-f]|[a-f]\d|[a-f][a-f])$/i
  HHEEXXAA = /^#(\d\d|\d[a-f]|[a-f]\d|[a-f][a-f])(\d\d|\d[a-f]|[a-f]\d|[a-f][a-f])(\d\d|\d[a-f]|[a-f]\d|[a-f][a-f])(|(\d\d|\d[a-f]|[a-f]\d|[a-f][a-f]))$/i
  HSL = /^hsl\((\d|\d\d|[1-2]\d{2}|(3([0-5]\d|60))),(| )(\d|\d\d|100)%,(| )(\d|\d\|100)%\)$/i
  HSLA = /^hsla\((\d|\d\d|[1-2]\d{2}|(3([0-5]\d|60))),(| )(\d|\d\d|100)%,(| )(\d|\d\|100)%(,|, )(1.0|0|1,0.\d)\)$/i

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
    str = ""
    for k in self.instance_variables
      str += "#{k}: #{self.instance_variable_get(k)}, "  
    end
    str[0..str.length-3]
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
      arr = code[4..(code.length-2)].split(/,/).map(&:strip).map(&:to_i)
      return {
        red: arr[0], 
        green: arr[1], 
        blue: arr[2], 
        alpha: 1.0, 
        type: format
      }
    when :RGBA
      arr = code[5..(code.length-2)].split(/,/).map(&:strip)
      return {
        red: arr[0].to_i, 
        green: arr[1].to_i, 
        blue: arr[2].to_i, 
        alpha: arr[3].to_f, 
        type: format
      }
    when :HSL
      arr = code[4..(code.length-2)].split(/,/).map(&:strip).map(&:to_i)
      return {
        hue: arr[0],
        saturation: arr[1],
        lightness: arr[2],
        alpha: 1,
        type: format
      }
    when :HSLA
      arr = code[5..(code.length-2)].split(/,/).map(&:strip)
      return {
        hue: arr[0].to_i,
        saturation: arr[1].to_i,
        lightness: arr[2].to_i,
        alpha: arr[3].to_f,
        type: format
      }
    when :HHEEXX
      return {
        red: code[1..2].to_i(16), 
        green: code[3..4].to_i(16), 
        blue: code[5..6].to_i(16), 
        alpha: 1.0,
        type: format
      }
    when :HHEEXXAA
      return {
        red: code[1..2].to_i(16), 
        green: code[3..4].to_i(16), 
        blue: code[5..6].to_i(16), 
        alpha: (code[7..9].to_i(16)/15.0).to_f,
        type: format
      }
    when :HEX
      return {
        red: code[1].to_i(16), 
        green: code[2].to_i(16), 
        blue: code[3].to_i(16), 
        alpha: 1.0,
        type: format
      }
    when :HEXA
      return {
        red: code[1].to_i(16), 
        green: code[2].to_i(16), 
        blue: code[3].to_i(16), 
        alpha: (code[4].to_i(16)/15.0).to_f,
        type: format
      }
    end
end

end
