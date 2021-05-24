defmodule Rockelivery.Users.UpdateTest do
  use Rockelivery.DataCase, async: true

  import Rockelivery.Factory

  alias Rockelivery.{Error, User}
  alias Rockelivery.Users.Update

  describe "call/1" do
    test "when all params are valid, returns the updated user" do
      id = "2a723b3f-8850-452c-bdbf-28b81edefd32"

      insert(:user)

      changes = %{"email" => "hero@hero.com", "id" => id}

      response = Update.call(changes)

      assert {:ok, %User{id: _id, age: 26, email: "hero@hero.com"}} = response
    end

    test "when any of the params are invalid, returns an error" do
      id = "2a723b3f-8850-452c-bdbf-28b81edefd32"

      insert(:user)

      changes = %{"age" => 11, "id" => id}

      response = Update.call(changes)

      expected = %{
        age: ["must be greater than or equal to 18"]
      }

      assert {:error, %Error{status: :bad_request, result: changeset}} = response
      assert errors_on(changeset) == expected
    end
  end
end
