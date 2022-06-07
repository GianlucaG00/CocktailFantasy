json.extract! review, :id, :text, :vote, :Drinker_id, :created_at, :updated_at
json.url review_url(review, format: :json)
