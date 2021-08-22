class Call < ApplicationRecord

  belongs_to :type, -> {select :name}, class_name: 'Plan', foreign_key: :plan_id


end
