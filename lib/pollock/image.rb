require 'RMagick'
module Pollock
  class Image
    
    DEFAULT_COLOUR = "#CCCCCC"
    FONT = "georgia"
    
    attr_accessor :height, :width, :text, :colour, :format
    def initialize(args={})
      args = build_args_from_string(args) if args.is_a? String
      raise ArgumentError.new("Image requires at least a size :height=>300") unless (args[:height]||args[:width]).to_i >0
      self.height = (args[:height]||args[:width]).to_i
      self.width = (args[:width]||args[:height]).to_i
      self.text = args[:text]
      self.colour = args[:colour]
      self.format = args[:format]||'jpg'
    end
    
    def format=(new_format)
      raise ArgumentError.new("Unknown image format") unless %w(jpg jpeg gif png).include? new_format
      @format=new_format
    end
    
    def text
      @text.to_s.empty? ? default_text : @text
    end
    
    def text=(new_text)
      @text = new_text.to_s.gsub('_', ' ') unless new_text.nil?
    end
    
    def colour=(new_colour)
      @colour = ("#"+new_colour.to_s).gsub("##", '#') if new_colour =~ /^#?[0-9a-f]{6}$/i
    end
    
    def colour
      @colour||DEFAULT_COLOUR
    end
    
    def text_colour
      "#CC0000"
    end
    
    def file_name
      parts = [default_text]
      parts << text.downcase.gsub(/[^a-z]/, '_') unless text == default_text
      parts << colour.gsub("#", '') unless colour == DEFAULT_COLOUR
      parts.join('-')+"."+format
    end

    def save(dir)
      path = File.join(dir, file_name)
      image.write(path)
      path
    end
    
    private
      def build_args_from_string(str)
        str, format = str.split(".")
        bits = str.split('-')
        height, width = bits.shift.to_s.split('x')
        width = height if width.nil?
        text = bits.shift
        colour = bits.shift
        {:colour=>colour, :text=>text, :height=>height, :width=>width, :format=>format}
      end
      
      def default_text
        "#{height}x#{width}"
      end
      
      def image
        the_colour = colour
        the_text_colour = text_colour
        img = Magick::Image.new(height, width) do 
          self.background_color = the_colour
        end
        
        image_text = Magick::Draw.new
        image_text.font_family = FONT
        image_text.pointsize = 20
        image_text.gravity = Magick::CenterGravity
        image_text.annotate(img, 0,0,0,0, self.text)
        image_text.fill = self.text_colour
        img
      end
  end
end


