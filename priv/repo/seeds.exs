# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Rockelivery.Repo.insert!(%Rockelivery.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Rockelivery.{Item, Order, Repo, User}

user_params = %{
  age: 27,
  address: "Rua Ca",
  cep: "12345678",
  cpf: "12345678901",
  email: "banana@banana.com",
  password: "banana",
  name: "Hugo"
}

user_changeset = User.changeset(user_params)

%User{id: user_id} = Repo.insert!(user_changeset)

item1 = %Item{
  category: :food,
  description: "Banana Frita",
  price: Decimal.new("15.50"),
  photo: "priv/photos/banana_frita.png"
}

item2 = %Item{
  category: :food,
  description: "Banana Assada",
  price: Decimal.new("10.30"),
  photo: "priv/photos/banana_assada.png"
}

Repo.insert!(item1)
Repo.insert!(item2)

order = %Order{
  user_id: user_id,
  items: [item1, item1, item2],
  address: "Rua Ca",
  comments: "Sem canela",
  payment_method: :money
}

Repo.insert!(order)
