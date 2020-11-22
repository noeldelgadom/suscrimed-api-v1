include ActionView::Helpers::TextHelper
puts "--------------------------"
puts "--------------------------"
puts "Starting Seeds"

# IVA Types
[0, 16].each { |p| IvaType.create(percentage:  p) }
puts pluralize(IvaType.count.to_s, IvaType.name)

# IEPS Types
[0, 8, 6, 25].each { |p| IepsType.create(percentage:  p) }
puts pluralize(IepsType.count.to_s, IepsType.name)
 

puts "Ending Seeds"
puts "--------------------------"
puts "--------------------------"