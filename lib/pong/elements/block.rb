# encoding: utf-8

module Pong
  class Block < Chingu::GameObject

    include Gosu
    include Chingu

    trait :bounding_box, :debug => false
    trait :collision_detection

    Material = Struct.new(:life, :image, :body)

    attr_accessor :material, :current_life
    attr_reader :destroyed

    def initialize options = {}
      super options

      @material = load_material(rand(100) % 3)
      @current_life = @material.life
      self.image = @material.image
      cache_bounding_box
    end

    def width
      self.image.width
    end

    def height
      self.image.height
    end

    def elastic?
      @material.body == :elastic
    end

    def destroyed?
      @destroyed == true
    end

    def hit!
      unless @current_life == 0
        @current_life -= 1
        new_image = load_image(@current_life)
        self.image = new_image if new_image
      else
        @destroyed = true
        self.visible = false
        self.destroy
      end
    end

    def self.all_destroyed?
      Block.size == 0
    end

    def self.plot! quantity
      block_x, block_y = 40, 40
      quantity.times do |n|
        if block_x >= Pong.width
          block_x = 40
          block_y += 60
        end

        Block.create :x => block_x, :y => block_y
        block_x += 60
      end
    end

    private
    def load_material material_number
      case material_number
        when 0 then Material.new(2, load_image(2), :solid)
        when 1 then Material.new(4, load_image(4), :elastic)
        when 2 then Material.new(6, load_image(6), :solid)
      end
    end

    def load_image life
      case life % 3
        when 0 then Image["resources/blocks/block_green.png"]
        when 1 then Image["resources/blocks/block_yellow.png"]
        when 2 then Image["resources/blocks/block_purple.png"]
      end
    end

  end
end




































