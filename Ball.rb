class Ball
    attr_accessor :x, :y, :vx, :vy
    attr_reader :image
    def initialize(window)
        @image = Gosu::Image.new(window, "./images/ball.png")
        @x = @y = 50
        @vx = @vy = 3
    end
    
    def draw
        @image.draw(@x, @y, 0)
    end
end
