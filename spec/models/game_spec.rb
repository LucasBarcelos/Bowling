require 'spec_helper'

describe Game do
  def roll_many(n, pins)
    n.times { subject.roll(pins) }
  end

  def roll_spare
    subject.roll(5)
    subject.roll(5)
  end

  def roll_strike
    subject.roll(10)
  end

  def score_should_be (value)
    expect(subject.score).to eq(value)
  end

  it 'tests gutter game' do
    roll_many(20, 0)
    score_should_be 0
  end

  it 'tests all ones' do
    roll_many(20, 1)
    score_should_be 20
  end

  it 'tests one spare' do
    roll_spare
    subject.roll(3)
    roll_many(17, 0)
    score_should_be 16
  end

  it 'tests one strike' do
    roll_strike
    subject.roll(3)
    subject.roll(4)
    roll_many(16, 0)
    score_should_be 24
  end

  it 'tests perfect game' do
    roll_many(12, 10)
    score_should_be 300
  end

  it 'jogo da maria' do
    subject.rolls = "1,4,4,5,6,4,5,5,10,0,1,7,3,6,4,10,2,8,6"
    score_should_be 133
  end
end
