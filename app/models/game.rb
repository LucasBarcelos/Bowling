class Game < ActiveRecord::Base

  def roll (pins)
    @rolls_array[@current_roll] = pins
    @current_roll += 1
  end

  def score
    puts rolls


    @rolls_array = rolls.split(',').map(&:to_i)
    @current_roll = 0

    score = 0
    frame_index = 0

    10.times do
      if strike? (frame_index)
        score += 10 + strike_bonus(frame_index)
        frame_index += 1
      elsif spare? (frame_index)
        score += 10 + spare_bonus(frame_index)
        frame_index += 2
      else
        score += @rolls_array[frame_index] + @rolls_array[frame_index + 1]
        frame_index += 2
      end
    end

    score
  end

  private
  def spare?(index)
    @rolls_array[index] + @rolls_array[index + 1] == 10
  end

  def strike?(index)
    @rolls_array[index] == 10
  end

  def spare_bonus(index)
    @rolls_array[index]
  end

  def strike_bonus(index)
    @rolls_array[index] + @rolls_array[index + 1]
  end
end
