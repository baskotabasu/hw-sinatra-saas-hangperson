class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  attr_accessor :word, :guesses, :wrong_guesses
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end
  
  def guess(g)
    raise ArgumentError unless g =~ /^[a-zA-Z]$/
    g.downcase!
    
    if @word.include?(g)
      if not @guesses.include?(g) 
        @guesses += g
        return true
      end

    else
      if not @wrong_guesses.include?(g)
        @wrong_guesses += g
        return true
      end
    end
    
    return false
  end
  
  def word_with_guesses
    display = ''
    @word.each_char do |w|
      if @guesses.include? w
        display += w
      else
        display += '-'
      end
    end
    return display
  end
  
  def check_win_or_lose
    return :win unless self.word_with_guesses.include? '-'
    return :lose if @wrong_guesses.length == 7
    return :play
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
