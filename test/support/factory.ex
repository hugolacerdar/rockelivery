defmodule Rockelivery.Factory do
  use ExMachina.Ecto, repo: Rockelivery.Repo

  alias Rockelivery.User

  def user_params_factory do
    %{
      "age" => 26,
      "address" => "Rua 2",
      "cep" => "01001000",
      "cpf" => "12345678923",
      "email" => "hugo@mailc.com",
      "name" => "Hugo",
      "password" => "123456"
    }
  end

  def user_factory do
    %User{
      age: 26,
      address: "Rua 2",
      cep: "01001000",
      cpf: "12345678923",
      email: "hugo@mailc.com",
      name: "Hugo",
      password: "123456",
      id: "2a723b3f-8850-452c-bdbf-28b81edefd32"
    }
  end

  def order_params_factory do
    %{
      "user_id" => "646ecc16-3499-4cc3-96d7-920ae61ca680",
      "items" => [
        %{"id" => "3a36f4db-aa0b-44bd-ac2d-19511bb3b423", "quantity" => 2},
        %{"id" => "d5baec7b-8610-4cd2-a843-ffa5cd5342c6", "quantity" => 4}
      ],
      "address" => "Rua 2 - Bairro Três",
      "comments" => "Sem banana",
      "payment_method" => "money"
    }
  end
end
