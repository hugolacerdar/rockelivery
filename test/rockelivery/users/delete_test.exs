defmodule Rockelivery.Users.DeleteTest do
  use Rockelivery.DataCase, async: true

  import Rockelivery.Factory

  alias Rockelivery.{Error, User}
  alias Rockelivery.Users.Delete

  describe "by_id/1" do
    test "when the id exists, deletes the user" do
      id = "2a723b3f-8850-452c-bdbf-28b81edefd32"

      insert(:user)

      response = Delete.call(id)

      assert {
               :ok,
               %User{
                 address: "Rua 2",
                 age: 26,
                 cep: "12345678",
                 cpf: "12345678923",
                 email: "hugo@mailc.com",
                 id: "2a723b3f-8850-452c-bdbf-28b81edefd32",
                 name: "Hugo",
                 password: nil,
                 password_hash: nil
               }
             } = response
    end

    test "when there is no user associated with the given id, returns an error" do
      id = "2a723b3f-8850-452c-bdbf-28b81edefC32"

      response = Delete.call(id)

      expected = {:error, %Error{result: "User not found", status: :not_found}}

      assert response == expected
    end
  end
end
