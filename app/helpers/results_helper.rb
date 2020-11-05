module ResultsHelper
  def noimage_cards_json
    x=Card.select do |card|
      !(File.exist?("app/assets/images/#{card.number}.jpg"))
    end
    y=x.map(&:number).zip(x.map{|c| c.name_ja || c.name_en})
    y.to_h.compact.to_json
  end

  def card_names_json
    x = Card.all.map(&:number).zip(Card.all.map{|c| c.name_ja || c.name_en})
    x.to_h.compact.to_json
  end
end
