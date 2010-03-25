require 'helper'

class TestPollock < Test::Unit::TestCase
  def setup
    @height = 200
    @width = 300
    @output_dir = File.join(File.dirname(__FILE__), 'tmp')
  end
  
  should 'Image should complain if it receives no arguments' do
    assert_raise ArgumentError do 
      Pollock::Image.new
    end
  end
  
  context "The String Constructor" do
    should "accept an explicit format" do
      image = Pollock::Image.new("200.png")
      assert_equal 'png', image.format
    end

    should "understand the a single argument constructor" do
      image = Pollock::Image.new("200.jpg")
      assert_equal 200, image.height
      assert_equal 200, image.width
    end
    
    should "understand different height and widths" do
      image = Pollock::Image.new("200x300.jpg")
      assert_equal 200, image.height
      assert_equal 300, image.width
    end
    
    should 'understand labels' do
      image = Pollock::Image.new("200-a_sample_label.jpg")
      assert_equal 'a sample label', image.text
      image = Pollock::Image.new("200.jpg")
      assert_equal '200x200', image.text
    end
    
    should "understand colours" do
      image = Pollock::Image.new("200--FF0000.jpg")
      assert_equal '#FF0000', image.colour
    end
    
    should "understand this" do
      image = Pollock::Image.new('305x100--FF0000.jpg')
      assert_equal 305, image.height
      assert_equal 100, image.width
      assert_equal '305x100', image.text
      assert_equal '#FF0000', image.colour
    end
    
  end
  
  context "Given an Image that only has a height" do
    setup {
      @image = Pollock::Image.new(:height=>@height)
    }
    
    should "set height to 200px" do
      assert_equal @height, @image.height
    end
    
    should "set width to the same as the height" do
      assert_equal @height, @image.width
    end
    
    should "set the text to '200x200'" do 
      assert_equal "#{@height}x#{@height}", @image.text
    end
    
    should "set the format to 'jpg'" do 
      assert_equal "jpg", @image.format
    end
    
    should "use the default background colour" do
      assert_equal "#CCCCCC", @image.colour
    end
    
    should "use the default text colour" do
      assert_equal "#CC0000", @image.text_colour
    end
    
    should "set the file_name" do
      assert_equal "#{@height}x#{@height}.jpg", @image.file_name
    end
    
    should "write out an image" do
      @image.save(@output_dir)
    end
  end
  
  context "Given an Image with a height and width" do
    setup {
      @image = Pollock::Image.new(:height=>@height, :width=>@width)
    }
    should "set height to 200px" do
      assert_equal @height, @image.height
    end
    
    should "set width to 200px" do
      assert_equal @width, @image.width
    end
    
    should "set the text to '200x300'" do 
      assert_equal '200x300', @image.text
    end
    
    should "set the filename correctly" do
      assert_equal "#{@height}x#{@width}.jpg", @image.file_name
    end
    
    should "write out an image" do
      @image.save(@output_dir)
    end
  end
  
  context "Given an Image with an explicit label" do
    setup {
      @text = "Wow! I'm a label"
      @image = Pollock::Image.new(:height=>@height, :text=>@text)
    }
    should "set the text to that value" do 
      assert_equal @text, @image.text
    end
    
    should "set the filename correctly" do
      assert_equal '200x200-wow__i_m_a_label.jpg', @image.file_name
    end
    
    should "write out an image" do
      @image.save(@output_dir)
    end
  end
  
  context "Given an explicit colour" do
    should "set the colour to that value" do
      colour = "#999AAA"
      image = Pollock::Image.new(:height=>@height, :colour=>colour)
      assert_equal colour, image.colour
    end

    should "accept a colour without a hash" do 
      colour = "999AAA"
      image = Pollock::Image.new(:height=>@height, :colour=>colour)
      assert_equal '#'+colour, image.colour
    end

    
    should "Ignore a colour that's invalid and keep the default" do
      image = Pollock::Image.new(:height=>@height, :colour=>"An invalid colour")
      assert_equal image.colour, Pollock::Image.new(:height=>100).colour
    end
    
    should "set the filename correctly" do
      colour = "999AAA"
      image = Pollock::Image.new(:height=>@height, :colour=>colour)
      assert_equal "200x200-999AAA.jpg", image.file_name
    end
    
  end
  
  context "Given an Image with an explicit format" do
    setup {
      @format = "png"
      @image = Pollock::Image.new(:height=>@height, :format=>@format)
    }
    should "set the text to that value" do 
      assert_equal @format, @image.format
    end
    
    should "set the file_name" do
      assert_equal "#{@height}x#{@height}.#{@format}", @image.file_name
    end
    
    should "Raise an exception for an unknown format" do
      assert_raise ArgumentError do
        Pollock::Image.new(:height=>@height, :format=>'bad_format')
      end
    end
    
    
    should "set the filename correctly" do
      assert_equal "200x200.png", @image.file_name
    end
    
    should "write out an image" do
      @image.save(@output_dir)
    end
    
  end
  
end
