# encoding: utf-8

module Pong
  class Ball < Chingu::GameObject

    include Gosu
    include Chingu

    traits :velocity, :bounding_circle, :collision_detection

    DEFAULT_MOVIMENT_UNIT = 4
    attr_accessor :moviment_unit, :bar

    def initialize options = {}
      @bar = options.delete :bar
      super options.merge(:image => Image["resources/bola.png"])

      @moviment_unit = DEFAULT_MOVIMENT_UNIT
      reset_position!
      calculate_velocity_y!
      cache_bounding_circle
    end

    def width
      self.image.width
    end

    def height
      self.image.height
    end

    def reset_position!
      self.x = ((Pong.width + width) / 2) - (width / 2)
      self.y = 300

      @direction = :down
      self.velocity_x = 0
      calculate_velocity_y!
    end

    def up?
      @direction == :up
    end

    def reach_top?
      self.y <= 0
    end

    def reach_bottom?
      self.y >= Pong.height
    end

    def reach_sides?
      self.x <= 0 or self.x >= Pong.width
    end

    def hit!
      calculate_velocity_x!
    end

    def change_direction!
      @direction = up? ? :down : :up
      calculate_velocity_y!
    end

    def force_right!
      self.velocity_x = self.velocity_x.abs
    end

    def force_left!
      self.velocity_x = -self.velocity_x.abs
    end

    def move!
      self.y = up? ? self.y - @moviment_unit : self.y + @moviment_unit
    end

    def update
      move!

      if reach_top?
        change_direction!
        calculate_velocity_y!
      end

      self.velocity_x = (-1 * self.velocity_x) if reach_sides?

      Ball.each_collision(Block) do |ball, block|
        unless block.destroyed?
          block.hit!
          @bar.player.score += 50
          @bar.player.update_score!
          change_direction!
          block.elastic? ? calculate_velocity_y!(1, 1) : calculate_velocity_y!
        end
      end

    end

    private
    def calculate_velocity_y! random = 1, bonus = 0
      value = 1 + rand(random)
      self.velocity_y = up? ? (-value - bonus) : (+value + bonus)
    end

    def calculate_velocity_x! random = 5
      value = @moviment_unit + rand(random)
      self.velocity_x = (self.velocity_x <= 0) ? -value : +value
    end

  end
end












