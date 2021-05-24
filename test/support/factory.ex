defmodule Rockelivery.Factory do
  use ExMachina.Ecto, repo: Rockelivery.Repo

  alias Rockelivery.User

  def user_params_factory do
    %{
      "age" => 26,
      "address" => "Rua 2",
      "cep" => "12345678",
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
      cep: "12345678",
      cpf: "12345678923",
      email: "hugo@mailc.com",
      name: "Hugo",
      password: "123456",
      id: "2a723b3f-8850-452c-bdbf-28b81edefd32"
    }
  end
end
