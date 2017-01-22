class AddSampleTypeToSamples < ActiveRecord::Migration
  def change
    add_column :samples, :sample_type, :string
  end
end
