# https://shiroyasha.svbtle.com/escape-sequences-a-quick-guide-1
# https://stackoverflow.com/questions/1489183/colorized-ruby-output-to-the-termina

module EscapeSequences
  # Movement

  def move_up(n); print "\e[#{n}A" end # up - moves n lines up
  def move_down(n); print "\e[#{n}B" end # down - moves n lines down
  def move_forward(n); print "\e[#{n}C" end #
end