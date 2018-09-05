color_pattern = /(#[0-9A-Fa-f]{3,6});/

def invert(color : Int) : String
  color_string 0xFFFFFF - color
end

def color_string(color : Int) : String
  "#" + color.to_s(base: 16, upcase: true)
end

def color_value(c_string : String) : Int
  if c_string.starts_with? '#'
    c_string[1..c_string.size].to_i base: 16
  elsif c_string.starts_with? "0x"
    c_string[2..c_string.size].to_i base: 16
  else
    raise Exception.new "invalid color value #{c_string}"
  end
end

out_str = ""

File.open("assets/css/screen.css").each_line do |line|
  color_match = line.match color_pattern
  unless color_match.nil?
    unless (color = color_match.captures[0]).nil?
      line = line.sub color_pattern do
        invert color_value color
      end
    end
  end
  out_str += line + '\n'
end


puts out_str
