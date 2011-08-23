# encoding: utf-8

module Pong
  class Player < Chingu::GameObject

    include Gosu
    include Chingu

    attr_accessor :score

    def initialize options = {}
      super options
      @text = nil
      @score = 0
    end

    def plot_score!
      @text = Text.create(:text=>"Score: #{@score}", :x => 20, :y => Pong.height - 30, :size => 20)
    end

    def update_score!
      @text.text = "Score: #{@score}" if @text
    end

  end
end