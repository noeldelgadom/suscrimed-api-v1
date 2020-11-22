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

# Tax Types
IvaType.all.each do |iva_type|
  IepsType.all.each do |ieps_type|
    TaxType.create(
      name:       "Iva" + iva_type.percentage.to_s + "-Ieps" + ieps_type.percentage.to_s,
      iva_type:   iva_type, 
      ieps_type:  ieps_type
    )
  end
end
puts pluralize(TaxType.count.to_s, TaxType.name)

puts "Ending Seeds"
puts "--------------------------"
puts "--------------------------"