class AddImageToPage < ActiveRecord::Migration
  def change
    add_reference :pages, :image, index: true
  end
end
