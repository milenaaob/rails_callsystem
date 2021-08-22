class Plan < ApplicationRecord

  def self.update
    self.delete_all

    Plan.create([

                  {id: 00, name: 'Nenhum', data_refer: 'calls.plan'},
                  {id: 30, name: 'FaleMais 30', data_refer: 'calls.plan'},
                  {id: 60, name: 'FaleMais 60', data_refer: 'calls.plan'},
                  {id: 120, name: 'FaleMais 120', data_refer: 'calls.plan'}

                ])

  end


end
