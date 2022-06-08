json.extract! review, :id, :text, :vote, :drinker_id, :bar_id, :created_at, :updated_at
json.url review_url(review, format: :json)
