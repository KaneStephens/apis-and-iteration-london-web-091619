def welcome
  "Welcome!"
end

def get_character_from_user
  puts "please enter a character name"
  character_name = gets.chomp
  character_name.downcase
end
