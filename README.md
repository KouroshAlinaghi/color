# color
A Little Library to Work With Colors (RGB and Hex for now)

# Usage

```
rgb = Color.new("(001,234,255)")
rgb.code # => "(1, 234, 255)"
rgb.red # => "001"
rgb.green # => "234"
rgb.blue # => "255"
rgb.type # => "RGB"
rgb.convert_to_hex # => "#01eaff"
rgb.convert_to_rgb # => Error: "Cannot Convert RGB to RGB" 
```
