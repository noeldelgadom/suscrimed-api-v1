class TaxType < ApplicationRecord
  belongs_to :iva_type
  belongs_to :ieps_type
end
