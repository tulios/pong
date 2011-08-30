# encoding: utf-8

module Pong
  class Player < Chingu::GameObject

    include Gosu
    include Chingu

    attr_accessor :score, :speed

    def initialize options = {}
      super options
      @text = nil
      @score = 0
      @speed = Bar::DEFAULT_MOVIMENT_UNIT
    end

    def plot_score!
      @text = Text.create(:text=>"Score: #{@score} | speed: #{@speed}", :x => 20, :y => Pong.height - 30, :size => 20)
    end

    def update_score!
      @text.text = "Score: #{@score} | speed: #{@speed}" if @text
    end

  end
end