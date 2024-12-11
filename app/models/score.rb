# app/models/score.rb
class Score < ApplicationRecord
    # Callback untuk otomatis mengisi submitted_at sebelum data disimpan
    before_create :set_submitted_at
  
    # Menambahkan format untuk response JSON
    def as_json(options = {})
      super(options).merge({
        submitted_at: submitted_at ? submitted_at.strftime("%d/%m/%Y %H:%M:%S") : nil,
        created_at: created_at.strftime("%d/%m/%Y %H:%M:%S"),
        updated_at: updated_at.strftime("%d/%m/%Y %H:%M:%S")
      })
    end
  
    private
  
    # Callback untuk set nilai submitted_at otomatis sebelum disimpan
    def set_submitted_at
      self.submitted_at ||= Time.now
    end
  end