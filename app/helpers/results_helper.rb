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

  def pick_data_json(picks)
    x=picks.map.with_index{|p,i| 
      idx = (i.even?) ? i/2 : i/2 + 7
      if p.persisted?
        [idx, {pick_number: p.pick_number, deck: p.card.number[0], card_number: p.card.number[1..3].to_i, used: p.used}]
      else
        [idx, {}]
      end
    }.to_h
    x.to_json
  end
end
