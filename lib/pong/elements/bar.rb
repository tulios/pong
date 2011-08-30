# encoding: utf-8

module Pong
  class Bar < Chingu::GameObject

    include Gosu
    include Chingu

    traits :bounding_box, :collision_detection

    DEFAULT_MOVIMENT_UNIT = 5
    attr_accessor :moviment_unit, :player

    def initialize options = {}
      @player = options.delete :player
      super options.merge(:image => Image["resources/barra.png"])

      @moviment_unit = DEFAULT_MOVIMENT_UNIT
      self.x = ((Pong.width + width) / 2) - (width / 2)
      self.y = (Pong.height - (height + 20))
      cache_bounding_box
    end

    def width
      self.image.width
    end

    def height
      self.image.height
    end

    def define_inputs!
      self.input = {
        :left => :move_left,
        :holding_left => :move_left,
        :right => :move_right,
        :holding_right => :move_right
      }
    end

    def move_left
      self.x -= @moviment_unit unless reach_left?
    end

    def move_right
      self.x += @moviment_unit unless reach_right?
    end

    def update
      super
      self.each_bounding_box_collision(Ball) do |bar, ball|
        ball.hit!
        ball.change_direction!
        ball.force_right! if holding? :right
        ball.force_left! if holding? :left
      end
    end

    private

    def reach_left?
      self.x <= self.width / 2
    end

    def reach_right?
      self.x >= Pong.width - (self.width / 2)
    end

  end
end




































