# card_generator.rb - defines the CardGenerator class (loading from text file to generate cards)

require './lib/card.rb'

class CardGenerator 
    #I'd rather not have a member variable referring to the same cards that 'Deck' class already knows about...
    attr_reader :cards

    def initialize(default_filename)
        #Read data from text file provided and construct card array
        #Then associate card array with deck
        @cards = []

        #There are multiple ways to read from a file, each through the File class.  Is one best?
        #Approach #1: read the whole file into a single string.  Quick single call, but then lots of parsing the string required
        # full_data_string = File.read("card_data.txt")
        #Approach #2: open the file, then read line by line via readline() or gets().  This is what I'll try for now
        #Approach #3: other methods and/or parsing approaches.  What is optimal?

        #Let's go with approach #2:
        #I've also added a more flexible loading process...
        file = open_data_file(default_filename)
        puts "Card information loaded.  Let's go!\n"

        #There are other ways to do this, no doubt, but this seems to work.
        #NOTE: gets() returns nil at end of file (EOF), but .readline() DOES NOT!  (Why???)
        while (new_line = file.gets()) != nil
            # substrings = new_line.split(",")

            question_string = (new_line.split(",")[0]).strip
            answer_string = (new_line.split(",")[1]).strip
            category = (new_line.split(",")[2]).strip.to_sym     #Needs to be a symbol to be compliant with other code/requirements

            new_card = Card.new(question_string, answer_string, category)
            @cards << new_card
        end
    end

    def open_data_file(default_filename)
        #Loads card information from specified data file, or default_filename otherwise
        #NOTE: Optional for later: don't forget to add comment-ignoring read functionality for text file (so I can add comments there)

        user_input_filename = ""        #To ensure variable scope later in method!

        loop do
            puts "Please type the file holding all card information, or press [enter] for default:"
            user_input_filename = gets

            if user_input_filename.chomp == ''          #Seems some invisible chars (more than just '\n') were present
                user_input_filename = default_filename
            end
            
            if File.exist?(user_input_filename.chomp) == true
                #Important: Need to use the exist?() method here, as open() with invalid path throws an error and I believe halts execution entirely.
                break
            else
                puts "File does not exist.  Let's try this again."
            end
        end

        return File.open(user_input_filename.chomp, 'r')         #Return the file object
    end

end