puts "Filename (include extension): "

filename = gets.chomp

path = File.read("./#{filename}")
path.gsub!(/\:/, "\n")
File.write("./#{filename}", path)
