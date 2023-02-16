"""
    encrypt(plaintext::String) -> Dict{Int64,String}
   
    This function encrypts a given plaintext message using a mapping of each character to a DNA code,
    with the output returned as a dictionary. It first creates an empty dictionary message to store 
    the encrypted message and sets the counter variable to zero. The function then creates an encryptionkey
    by calling a function _build with DNAEncryptionKey. The for loop runs through each character 
    in the plaintext string by first mapping it to a corresponding DNA code in the encryptionkey and then 
    adding the code to the message dictionary at the current position, which is tracked by the counter. 
    Finally, the function returns the message dictionary containing the encrypted message.
"""

function encrypt(plaintext::String)::Dict{Int64,String}
  
    # initialize -
    message = Dict{Int64,String}()
    counter = 0;

    # build encryptionkey -
    encryption_model = _build(DNAEncryptionKey);
    encryptionkey = encryption_model.encryptionkey;

    for c ∈ uppercase(plaintext)

        # encrypt -
        message[counter] = encryptionkey[c]

        # update the counter -
        counter = counter + 1
    end

    # return -
    return message

end

"""
    decrypt(encrypteddata::Dict{Int64,String}) -> String

    This function decrypts an encrypted message and returns the original plaintext message. 
    It first initializes some variables to be used in the decryption process, including a dictionary 
    for the inverse mapping of DNA codons to characters, plaintext to store the resulting characters,
    and the length of the encrypted message. The function then creates an encryptionkey using
    the same method as the encrypt function. The inverse mapping is then created by swapping
    the keys and values of the original encryptionkey. The for loop then runs over 
    each DNA code in the encrypted message, grabs the corresponding character from
    the inverse dictionary, and adds it to the plaintext vector. Finally, the decrypted
    message is returned as a single string by joining the characters in the plaintext vector.


"""
function decrypt(encrypteddata::Dict{Int64,String})::String
    
   # initialize -
   number_of_chars = length(encrypteddata)
   inverse_encryptionkey_dict = Dict{String, Char}()
   plaintext = Vector{Char}()

   # build encryptionkey -
   encryption_model = _build(DNAEncryptionKey);
   encryptionkey = encryption_model.encryptionkey;

   # build the inverse_key -
   for (key, value) ∈ encryptionkey
       inverse_encryptionkey_dict[value] = key
   end

   for i ∈ 0:(number_of_chars - 1)
       
       codon = encrypteddata[i]
       value = inverse_encryptionkey_dict[codon]
       push!(plaintext, value)
   end

   # return -
   return String(plaintext)


end