defmodule RockeliveryWeb.UsersViewTest do
  use RockeliveryWeb.ConnCase, async: true
  import Phoenix.View
  import Rockelivery.Factory
  alias RockeliveryWeb.UsersView

  test "renders create.json" do
    user = build(:user)
    token = "xpto1234"
    response = render(UsersView, "create.json", user: user, token: token)

    assert response == %{
             message: "User created successfully!",
             token: "xpto1234",
             user: %Rockelivery.User{
               address: "Rua 2",
               age: 26,
               cep: "01001000",
               cpf: "12345678923",
               email: "hugo@mailc.com",
               id: "2a723b3f-8850-452c-bdbf-28b81edefd32",
               inserted_at: nil,
               name: "Hugo",
               password: "123456",
               password_hash: nil,
               updated_at: nil
             }
           }
  end
end
