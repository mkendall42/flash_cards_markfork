# card_generator_spec.rb - run RSpec based tests on Deck class
#NOTE: there are several results from 'puts' due to it being run in several tests.  Is there a way to suppress that output here if I wish?
require './lib/card.rb'
require './lib/deck.rb'
require './lib/turn.rb'
require './lib/round.rb'
require './lib/card_generator.rb'
require 'rspec'
require 'pry'

describe CardGenerator do
    #UPDATE THIS CODE APPROPRIATELY
    #This allows me to not have to re-create this each time.  Admittedly, not much faster than copy/paste, but fun different thing to try!
    before(:each) do
        @filename = "cards_data.txt"
        @cards = CardGenerator.new(@filename).cards
    end

    #NOTE: how do I really 'test' some of the innards of e.g. initialize() without being really tedious / indirect?

    it 'initializes correctly: file is valid' do
        f = File.open(@filename, 'r')
        expect(f).to be_a(File)
    end

    it 'initializes correctly: first card exists' do
        expect(@cards).to be_a(Array)
    end

    it 'initializes correctly: correct # of cards exist' do
        expect(@cards.length).to eq(4)
    end

    it 'initializes correctly: third card has correct information' do
        #Again, this feels fragile, having to target one specific card...it will break if the text file changes, etc.
        #How to generalize, e.g. to ensure each card has valid strings / data types present; and spot check still?
        expect(@cards[2].question).to eq("What is Mike's middle name?")
        expect(@cards[2].answer).to eq("nobody knows")
        expect(@cards[2].category).to eq(:Turing_staff)
        #Do I really have to break these each into a separate test?  Feels very tedious at that point...
    end

    it 'loads default file correctly in open_data_file()' do
        #This one is weird - this method has already worked once initialize() happens.
        #Also I'm not sure how it handles encountering gets()
        card_generator = CardGenerator.new(@filename)
        
        default_file = card_generator.open_data_file(@filename)

        expect(default_file).to be_a(File)
        expect(default_file.readline.strip).to eq("What is 5 + 5?,10,STEM")
    end

    it 'loads a specified file correctly in open_data_file()' do
        #Same as before with issues.  Can't really test gets() part.
        card_generator = CardGenerator.new("cards_moredata.txt")
        
        default_file = card_generator.open_data_file("cards_moredata.txt")

        expect(default_file).to be_a(File)

        default_file.readline       #To advance another line through file to get to unique line

        expect(default_file.readline.strip).to eq("What is the capital of Alaska?,Juneau,Geography")
    end        

end
