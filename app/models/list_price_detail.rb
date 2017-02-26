class ListPriceDetail < ApplicationRecord
  belongs_to :category
  belongs_to :service
  belongs_to :list_price
end
