class ChangeColumnToUser < ActiveRecord::Migration[5.0]
  def up
    change_column_default :plans, :status, '0'
  end
  
  def down
    change_column_default :plans, :status, nil
  end
end
