# frozen_string_literal: true

require_relative './styleable.rb'
# Includes all functionality for outputting to the console
module Displayable
  include Styleable

  def title
    <<~HEREDOC
      #{'----------------------------------------------------------------'.center 80}
      #{stylize '|  H A N G M A N  |'.center(80), BOLD}
      #{'----------------------------------------------------------------'.center 80}
    HEREDOC
  end

  def start_screen
    clear_screen
    <<~HEREDOC


      The objective is to save #{CHARACTER_NAME} from getting hung up on accusations of witchery. You get 7 turns.

      #{BULLET} All words are pulled from a dictionary and will be 5 - 12 characters long.

      #{BULLET} Upu'll be able to guess a letter or the entire word if you already figure it out.


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
      "  (#{index + 1}) #{File.basename(file, '.*').capitalize}"
    end.join("\n")
  end

  def no_saved_games_message
    "Oops! You haven't saved any games. Type #{stylize '/back', BOLD} to go to the start screen."
  end

  def successful_save
    'Your games has been saved successfully.'
  end

  def load_a_game_screen(files)
    return no_saved_games_message if files.empty?

    <<~HEREDOC
      Which game would you like to continue?
      #{show_filenames files}
    HEREDOC
  end

  def find_drawable_parts(incorrect_guesses)
    HANGMAN_BODY_PARTS.each_with_object({}) do |(body_part, content), hash|
      minimum_mistakes = content[0]
      symbol = content[1]

      hash[body_part] = incorrect_guesses > minimum_mistakes ? symbol : ' '
    end
  end

  def stick_figure(incorrect_guesses)
    drawable_parts = find_drawable_parts incorrect_guesses

    <<~HEREDOC.chomp
      #{SCREEN_INDENT} #{drawable_parts[:head]}#{HEAD_AND_TORSO_INDENT}#{SQUARE}
      #{SCREEN_INDENT} #{drawable_parts[:left_arm]}#{drawable_parts[:neck]}#{drawable_parts["right_arm"]}#{EXTREMITIES_INDENT}#{SQUARE}
      #{SCREEN_INDENT} #{drawable_parts[:torso]}#{HEAD_AND_TORSO_INDENT}#{SQUARE}
      #{SCREEN_INDENT} #{drawable_parts[:left_leg]}#{drawable_parts[:right_leg]}#{EXTREMITIES_INDENT}#{SQUARE}}
    HEREDOC
  end

  def hangin_man_drawing(incorrect_guesses)
    <<~HEREDOC

      #{SCREEN_INDENT}#{TOP_BAR}#{SQUARE}#{SQUARE}
      #{SCREEN_INDENT}#{ROPE}#{' ' * (ROPE_TO_POLE_INDENT + 3)}#{POLE}
      #{SCREEN_INDENT}#{ROPE}#{' ' * (ROPE_TO_POLE_INDENT + 2)}#{POLE}
      #{SCREEN_INDENT}#{ROPE}#{' ' * (ROPE_TO_POLE_INDENT + 1)}#{POLE}
      #{SCREEN_INDENT}#{ROPE}#{' ' * (ROPE_TO_POLE_INDENT)}#{POLE}
      #{stick_figure incorrect_guesses}
      #{SCREEN_INDENT}#{POLE_INDENT}#{POLE}
      #{SCREEN_INDENT}#{BOTTOM_BAR_INDENT}#{BOTTOM_BAR}
    HEREDOC
  end

  def hide_secret_word(secret_word, remaining_letters)
    remaining_letters.split('').each do |remaining_letter|
      secret_word = secret_word.gsub remaining_letter, '_'
    end

    mystery_word = secret_word.split('').join(' ')
    <<~HEREDOC

      #{stylize mystery_word.center(80), BOLD}

    HEREDOC
  end

  def incorrect_guess_list(incorrect_guesses)
    "#{colorize incorrect_guesses.join('   |   ').center(80), COLORS[:bg][:red]}\n\n"
  end

  def method_name
    
  end
end