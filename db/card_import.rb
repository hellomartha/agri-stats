require 'csv'
class CardImport
  def self.exec
    list = File.read("#{Rails.root.to_path}/db/card_list.csv")
    CSV.parse(list, headers: true).each do |row|
      x = Card.find_or_initialize_by(number: row.to_hash["number"])
      x.update(row.to_hash)
    end
  end
end
CardImport.exec
