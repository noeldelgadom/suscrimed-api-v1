include ActionView::Helpers::TextHelper
puts "--------------------------"
puts "--------------------------"
puts "Starting Seeds"

# IVA Types
[0, 16].each { |p| IvaType.create(percentage:  p) }
puts pluralize(IvaType.count.to_s, IvaType.name)



puts "Ending Seeds"
puts "--------------------------"
puts "--------------------------"