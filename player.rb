class Player
    attr_accessor :x, :y, :vx, :score
    attr_reader :image
    
    def initialize(window,src)
        @image = Gosu::Image.new(window, src)
        @x = (Game::WIDTH - @image.width)/2
        @y = Game::HEIGHT - @image.height - 10
        @vx = @vy = 5
        @score = 0
    end
    def draw
        @image.draw @x,@y,1
    end
    def left
        @x -= 6
        @x = [0, @x].max
    end
    def right
        @x += 6
        @x = [Game::WIDTH - @image.width, @x].min
        
    end
end
