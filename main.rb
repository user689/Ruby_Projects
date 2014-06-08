require 'gosu'
require_relative 'menu.rb'
require_relative 'player.rb'
require_relative 'ball.rb'
class Game < Gosu::Window
    WIDTH = 640
    HEIGHT = 480
    Ran = Random.new     
    def initialize
        super WIDTH, HEIGHT, false
        self.caption = "Pong Game v 1.0"
        @ball = Ball.new(self)
        @player_1 = Player.new(self, "./images/player_1.png")
        @player_2 = Player.new(self, "./images/player_2.png")
        @player_2.y = 10
        @font = Gosu::Font.new(self, 'Arial', 20)
        @menu = Menu.new(self)
        @menu.add_item(Gosu::Image.from_text(self,"Start Game", 'Arial', 20), WIDTH/2 - 198/2, (HEIGHT - 39)/2, 1, lambda{@show_game = true})
        @menu.add_item(Gosu::Image.from_text(self,"Exit", 'Arial', 20), WIDTH/2 - 197/2, (HEIGHT - 39 +198/2)/2, 1, lambda {self.close})
        @cursor = Gosu::Image.new(self, "./images/cursor.png")        
    end
    
    def button_down (id)
       if id == Gosu::MsLeft
               @menu.clicked
       end
    end
    def draw_border
       
    end
       
    
    def hits?(p , b)
        if -(b.y - p.y) <= b.image.height
            if b.x <= p.x
                if -(b.x - p.x)< b.image.width
                    return true
                end
        else 
                if (b.x - p.x) < p.image.width
                    return true
                else 
                    return false
                end
            end
        end   
    end
    
    def hits2?(p , b)
        if (b.y - p.y) <= p.image.height
            if b.x <= p.x
                if -(b.x - p.x)< b.image.width
                    return true
                return false
                end
            else 
                if (b.x - p.x) < p.image.width
                    return true
                return false
                end
            end
        end    
        return false
    end
    
    def move_player(player, r, l)
        if button_down?(r)
            player.right
        elsif button_down?(l) 
            player.left
        end
    end
    def move_ball
        @ball.x += @ball.vx
        @ball.y += @ball.vy
    end
    def wins
       if @player_1.score == 10
           return 1
       elsif @player_2.score == 10
           return 2
        end   
        return
    end
    def check_for_collision
    
        if  hits? @player_1, @ball
            @ball.vx = 5 if button_down?(Gosu::KbRight)       
            @ball.vy *= -1

        elsif hits2? @player_2, @ball
            if button_down?(Gosu::KbD)
                @ball.vx = 5
            end         
            @ball.vy *= -1
        else
            if @ball.x >= WIDTH - @ball.image.width
                @ball.vx = -5
            elsif @ball.x <=0
                @ball.vx =  5
            end
            ## Game Over ##
             if @ball.y + @ball.image.width > 480
                 @ball.x = ( WIDTH - @ball.image.width - -Ran.rand(40..80))/2
                 @ball.y = ( HEIGHT - @ball.image.height )/2
                 @ball.vx = %w{-2 2}.sample.to_i
                 @ball.vy = -2
                 @player_2.score +=1
             elsif @ball.y < -10
                 @ball.x = (WIDTH - @ball.image.width - Ran.rand(40..80))/2
                 @ball.y = (HEIGHT - @ball.image.height)/2
                 @ball.vx = %w{-2 2}.sample.to_i
                 @ball.vy  = 2
                 @player_1.score +=1
             end
        end
    end
    def update
        if @show_game != true
            @menu.update
        else
            if !wins
                check_for_collision
                move_ball
                move_player(@player_1, Gosu::KbRight, Gosu::KbLeft)
                move_player(@player_2, Gosu::KbD, Gosu::KbA)
            else 
                @menu2.update
            end
        end
    end
=begin
For testing purposes
        if @player_1.x >= 500
            @player_1.vx = -5
        elsif @player_1.x <= 0
            @player_1.vx = 5
        end
        @player_1.x += @player_1.vx 
=end
    def draw
        if @show_game != true
             @menu.draw
             @cursor.draw self.mouse_x, self.mouse_y, 0
        else
            if wins
                @font.draw("Game over", WIDTH/4+ 120/2, HEIGHT/2 - 120/2, 0, 2, 5,Gosu::Color::RED)
                @font.draw("Player #{wins} wins", WIDTH/4 +100, HEIGHT/2 +20, 0,1,2)
               
            else
                @font.draw("Player 1: #{@player_1.score}", 10, 10, 2,1,1, Gosu::Color::RED)  #,1,1, Gosu::Color::WHITE)
                @font.draw("Player 2: #{@player_2.score}", 10,25,2, 1, 1, Gosu::Color::GREEN)    #,1,1, Gosu::Color::WHITE)
                @ball.draw
                @player_1.draw
                @player_2.draw
            end
        end
    end
end

Game.new.show
