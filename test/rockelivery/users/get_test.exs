defmodule Rockelivery.Users.GetTest do
  use Rockelivery.DataCase, async: true

  import Rockelivery.Factory

  alias Rockelivery.{Error, User}
  alias Rockelivery.Users.Get

  describe "by_id/1" do
    test "when the id exists, returns its user" do
      id = "2a723b3f-8850-452c-bdbf-28b81edefd32"

      insert(:user)

      response = Get.by_id(id)

      assert {:ok, %User{id: _id, age: 26, email: "hugo@mailc.com"}} = response
    end

    test "when there is no user associated with the given id, returns an error" do
      id = "2a723b3f-8850-452c-bdbf-28b81edefC32"

      response = Get.by_id(id)

      expected = {:error, %Error{result: "User not found", status: :not_found}}

      assert response == expected
    end
  end
end
