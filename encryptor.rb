class Encryptor
  
  #def encrypt_letter(letter)
  #  lowercase_letter = letter.downcase
  #  cipher[lowercase_letter]
  #end
  
  def encrypt_letter(letter, rotation)
    cipher_for_rotation = cipher(rotation)
    cipher_for_rotation[letter]
  end
  
  def encrypt(string, rotation)
    # 1. Cut the input string into letters
    letters = string.split("")
    
    # 2. Encrypt those letters one at a time, gathering the results
      #results = []
      #letters.each do |letter|
      #  encrypted_letter = encrypt_letter(letter)
      #  results << encrypted_letter
      #end
    #Refactored 2
    results = letters.collect { |letter| encrypt_letter(letter, rotation)}
    
    # 3. Join the results back together in one string
    results.join
  end
  
  def decrypt_letter(letter, rotation)
    lowercase_letter = letter.downcase
    cipher(rotation).key(lowercase_letter)
  end
  
  def decrypt(string, rotation)
    letters = string.split("")
    
    results = letters.collect { |letter| decrypt_letter(letter, rotation)}
    
    results.join
  end
  
  def decrypt_file(filename, rotation)
    #Create the file handle to the encrypted file
    input = File.open(filename, "r")
    #Read the encrypted text
    read_input = input.read
    #Decrypt the text by passing in the text and rotation
    decrypted_text = decrypt(read_input, 13)
    #Create a name for the decrypted file
    output_file = filename.gsub("encrypted","decrypted")
    # Write out the text
    out = File.open(output_file, 'w')
    out.write(decrypted_text)
    #close the file
    out.close
    
  end
  
  #def cipher
  #  {'a' => 'n', 'b' => 'o', 'c' => 'p', 'd' => 'q',
  #   'e' => 'r', 'f' => 's', 'g' => 't', 'h' => 'u',
  #   'i' => 'v', 'j' => 'w', 'k' => 'x', 'l' => 'y',
  #   'm' => 'z', 'n' => 'a', 'o' => 'b', 'p' => 'c',
  #   'q' => 'd', 'r' => 'e', 's' => 'f', 't' => 'g',
  #   'u' => 'h', 'v' => 'i', 'w' => 'j', 'x' => 'k',
  #   'y' => 'l', 'z' => 'm'}
  #end
  
  def cipher(rotation)
    characters = (' '..'z').to_a
    rotated_characters = characters.rotate(rotation)
    Hash[characters.zip(rotated_characters)]
  end
  
  def encrypt_file(filename, rotation)
    #create the file handle to the input file
    input = File.open(filename, "r")
    #Read the text of the input file
    read_input = input.read
    #Encrypt the text
    encrypted_text = encrypt(read_input, 13)
    #Create a name for the output file
    output_file = "output.txt.encrypted"
    #Create an output file handle
    out = File.open(output_file, 'w')
    #Write out the text
    out.write(encrypted_text)
    # close the file
    out.close
  end
  
end

e = Encryptor.new
# puts e.encrypt_letter('M')           #-> z
#puts "Hello world".split("o")  #-> ["Hell","w","rld"]
#puts "hello world".split("")         #-> array of each letter

#puts e.encrypt("hello")
#puts e.decrypt("uryyb")
#Refactoring
#sample = ["a","b","c"]
#capitals = sample.collect{ |letter| letter.upcase }
#puts capitals                                             #collect returns an array unlike each where we would have to push each element to an array on our own
#puts (' '..'z').to_a.inspect

#puts ('a'..'z').to_a.inspect
#puts ('a'..'z').to_a.rotate(13).inspect

#rotation = 13
#characters = ('a'..'z').to_a
#rotated_characters = characters.rotate(rotation)
#pairs = characters.zip(rotated_characters)              #zip takes to arrays and zips them up [[a, n], [b, o] etc.. 
#puts Hash[pairs]                                        # this converts the array of pairs into a hash



#puts e.encrypt_letter("a",13)  #n
encrypted = e.encrypt("hello world", 13)
puts e.decrypt(encrypted, 13)

out = File.open('sample.txt', 'w')
out.write("hello, world \n")
out.write("This is a file, hooray")
out.close

input = File.open("sample.txt", "r")
input.rewind
puts input.read

e.encrypt_file("sample.txt",13)

e.decrypt_file('output.txt.encrypted', 13)
