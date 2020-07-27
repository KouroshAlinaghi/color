module ColorHelper

  RGB = /^\((\d{1,2}|([01][0-9][0-9]|((25[0-5])|2[0-4]\d))),(| )(\d{1,2}|([01][0-9][0-9]|((25[0-5])|2[0-4]\d))),(| )(\d{1,2}|([01][0-9][0-9]|((25[0-5])|2[0-4]\d)))(|(,|, )(0|1|0.\d|1.0))\)$/i
  HEX = /^#(\d|[a-f])(\d|[a-f])(\d|[a-f])(|(\d|[a-f]))$/i
  SIX_DIGIT_HEX = /^#(\d\d|\d[a-f]|[a-f]\d|[a-f][a-f])(\d\d|\d[a-f]|[a-f]\d|[a-f][a-f])(\d\d|\d[a-f]|[a-f]\d|[a-f][a-f])(|(\d\d|\d[a-f]|[a-f]\d|[a-f][a-f]))$/i

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
    "Code: #{@code}, Type: #{@type}, Red: #{@red}, Green: #{@green}, Blue: #{@blue}, Alpha: #{@alpha}"
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
      arr = code[1..(code.length-2)].split(/,/).map(&:strip)
      return {
        red: arr[0].to_i, 
        green: arr[1].to_i, 
        blue: arr[2].to_i, 
        alpha: arr[3].to_f || 1.0, 
        type: format
      }
    when :SIX_DIGIT_HEX
      return {
        red: code[1..2].to_i(16), 
        green: code[3..4].to_i(16), 
        blue: code[5..6].to_i(16), 
        alpha: code[7..9] == "" ? 1.0 : (code[7..9].to_i(16)/255.0).round(1).to_f,
        type: format
      }
    when :HEX
      return {
        red: code[1].to_i(16), 
        green: code[2].to_i(16), 
        blue: code[3].to_i(16), 
        alpha: code[4].nil? ? 1.0 : (code[4].to_i(16)/15.0).round(1).to_f,
        type: format
      }
    end
  end
end
