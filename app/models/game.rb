class Game < ActiveRecord::Base

  def roll(pins)
    self.rolls ||= ""
    self.rolls += ', ' unless self.rolls.blank?
    self.rolls += pins.to_s
  end

  def frames
    frames = []
    arr = rolls.split(',').map(&:to_i).in_groups_of 2
    arr.each {|frame| frames << Frame.new(frame[0], frame[1])}
    frames
  end

  def score
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
    @rolls_array[index + 2]
  end

  def strike_bonus(index)
    @rolls_array[index + 1] + @rolls_array[index + 2]
  end
end
