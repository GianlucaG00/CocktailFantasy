Canard::Abilities.for(:drinker) do
  can [:read], Bar
  cannot [:destroy, :create, :update], Bar
  can [:read], Cocktail
  cannot [:destroy, :create, :update], Cocktail
end
