require 'game'
require 'rspec'

describe 'Game' do
  it 'test to lose game' do
    game = Game.new('тест')
    expect(game.status).to eq :in_progress
    game.next_step 'а'
    game.next_step 'в'
    game.next_step 'п'
    game.next_step 'у'
    game.next_step 'т'
    game.next_step 'о'
    game.next_step 'ъ'
    game.next_step 'к'
    expect(game.errors).to eq 7
    expect(game.status).to eq :lost
  end

  it 'test to win game' do
    game = Game.new('тест')
    expect(game.status).to eq :in_progress
    game.next_step 'т'
    game.next_step 'е'
    game.next_step 'с'
    expect(game.errors).to eq 0
    expect(game.status).to eq :won
  end
end
