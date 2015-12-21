class Rectangle

  attr_accessor :height, :width

  def initialize(input_hash)
    @width = input_hash[:width]
    @height = input_hash[:height]
  end

  def area
    @height * @width
  end

end





# Create a Rectangle class with readable width and height attributes
# and a method to calculate its area.



# Driver code
rectangle = Rectangle.new(height: 10,width: 30)
p rectangle.width # should be 10
p rectangle.height # should be 30
p rectangle.area # should be 300