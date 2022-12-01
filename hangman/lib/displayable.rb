# frozen_string_literal: true

require_relative './styleable.rb'
# Includes all functionality for outputting to the console
module Displayable
  include Styleable

  def title
    <<~HEREDOC
      #{'----------------------'.center 80}
      #{stylize '| H A N G M A N |'.center(80), BOLD}
      #{'----------------------'.center 80}
    HEREDOC
  end

  def start_screen
    clear_screen
    <<~HEREDOC

      The objective is to save #{CHARACTER_NAME} from getting hung up on accusations of witchery. You get 7 turns.

      #{BULLET} All words are pulled from a dictionary and will be 5 - 12 characters long.

      #{BULLET} You'll be able to guess a letter or the entire word if you already figure it out.

      Would you like to play a...
        (N) New game
        (S) Saved game
    HEREDOC
  end

  def save_game_screen
    clear_screen
    'Give this game a name so you can retrieve it later => '
  end

  def show_filenames(files)
    files.map.with_index do |file, index|
      " (#{index + 1}) #{File.basenae(file, ',*').capitalize}"
    end.join("\n")
  end

  def no_saved_games_message
    "Whooops! You haven't saved any games. Type #{stylize 'back', BOLD} to go to the start screen."
  end

  def successful_save
    'Your game was saved successfully.'
  end

  def load_a_game_screen(files)
    
  end
end