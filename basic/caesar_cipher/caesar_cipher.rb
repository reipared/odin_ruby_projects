def caesar_cipher(string, factor)
  dictionary_lowercase = ('a'..'z').to_a
  dictionary_uppercase = ('A'..'Z').to_a
  starting_array = string.split('')

  finish_array = starting_array.map do |char|
    if !(('a'..'z').to_a + ('A'..'Z').to_a).include?(char)
      char = char

    # iterate over capital letters
    elsif char.upcase == char
      index = (dictionary_uppercase.index(char.to_s) + factor) % 26
      dictionary_uppercase[index]

    # iterate over lowercase letters
    elsif char.downcase == char
      index = (dictionary_lowercase.index(char.to_s) + factor) % 26
      dictionary_lowercase[index]
    end
  end
  finish_array.join('')
end

p caesar_cipher('What a string!', 5)