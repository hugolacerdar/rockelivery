defmodule Rockelivery.Users.CreateTest do
  use Rockelivery.DataCase, async: true

  import Mox
  import Rockelivery.Factory

  alias Rockelivery.ViaCep.ClientMock

  alias Rockelivery.{Error, User}
  alias Rockelivery.Users.Create

  describe "call/1" do
    test "when all params are valid, returns the user" do
      params = build(:user_params)

      expect(ClientMock, :get_cep_info, fn _cep ->
        {:ok, build(:cep_info)}
      end)

      response = Create.call(params)

      assert {:ok, %User{id: _id, age: 26, email: "hugo@mailc.com"}} = response
    end

    test "when any of the params are invalid, returns an error" do
      params = build(:user_params, %{"age" => 11, "cpf" => "123456"})

      response = Create.call(params)

      expected = %{
        age: ["must be greater than or equal to 18"],
        cpf: ["should be 11 character(s)"]
      }

      assert {:error, %Error{status: :bad_request, result: changeset}} = response
      assert errors_on(changeset) == expected
    end
  end
end
