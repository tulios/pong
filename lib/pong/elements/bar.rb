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
      self.x -= @moviment_unit
    end

    def move_right
      self.x += @moviment_unit
    end

    def update
      Ball.each_collision(Bar) do |ball, bar|

        ball.change_direction!

        # Nasty fix to avoid gameOver on collision detection lag
        if bar.y < ball.y
          unless ball.up?
            ball.change_direction!
            ball.velocity_x = 0
          end
        else
          ball.hit!
        end

        ball.force_right! if holding? :right
        ball.force_left! if holding? :left
      end
    end

  end
end




































