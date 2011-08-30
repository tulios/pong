# encoding: utf-8

module Pong
  class PowerUp < Chingu::GameObject

    include Gosu
    include Chingu

    trait :bounding_box, :debug => false
    trait :collision_detection

    DEFAULT_MOVIMENT_UNIT = 4

    def initialize options = {}
      @text = Text.create(:text=>"+1 speed", :size => 20)
      super options.merge(:image => Pong.text_to_image(@text))

      @gray = Gosu::Color.new(0xCDCDCD)
      @white = Gosu::Color.new(0xFFFFFFFF)

      self.width = @text.width
      self.height = @text.height

      @text.x = self.x
      @text.y = self.y

      cache_bounding_box
    end

    def fall!
      self.y += DEFAULT_MOVIMENT_UNIT
      @text.y = self.y
    end

    def die!
      self.destroy
      self.visible = false
    end

    def reach_bottom?
      self.y >= Pong.height
    end

    def detect_colision
      self.each_bounding_box_collision(Bar) do |power_up, bar|
        if power_up.visible?
          self.visible = false

          bar.increase_speed!
          bar.mode = :additive

          bar.during(10*1000) do
            bar.color == @gray ?  bar.color = @white: bar.color = @gray
          end.then do
            bar.mode = :default
            bar.decrease_speed!  if bar.speed_bonus > 0
          end

          self.die! if self.reach_bottom?
        end
      end
    end

    def update
      fall!
      detect_colision
      die! if reach_bottom?
    end

  end
end


















