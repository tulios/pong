# encoding: utf-8

module Pong
  class Ball < Chingu::GameObject

    include Gosu
    include Chingu

    trait :velocity
    trait :bounding_box
    trait :collision_detection

    DEFAULT_MOVIMENT_UNIT = 4
    attr_accessor :moviment_unit

    def initialize options = {}
      super options.merge(:image => Image["resources/bola.png"])

      @moviment_unit = DEFAULT_MOVIMENT_UNIT
      reset_position!
      calculate_velocity_y!
    end

    def width
      self.image.width
    end

    def height
      self.image.height
    end

    def reset_position!
      self.x = ((Pong.width + width) / 2) - (width / 2)
      self.y = 20

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
        calculate_velocity_y! 15
      end

      self.velocity_x = (-1 * self.velocity_x) if reach_sides?
    end

    private
    def calculate_velocity_y! random = 5
      value = @moviment_unit + rand(random)
      velocity_y = up? ? -value : +value
    end

    def calculate_velocity_x! random = 5
      value = @moviment_unit + rand(random)
      self.velocity_x = (self.velocity_x <= 0) ? -value : +value
    end

  end
end












