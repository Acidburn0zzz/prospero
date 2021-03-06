# frozen_string_literal: true

# Prospero
#
# You should have received a copy of the license along with this program.
#
# Licensed under
# - GNU Affero General Public License V3
# - CeCILL Affero compliant
class AddFullNameToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :full_name, :text, null: false
  end
end
