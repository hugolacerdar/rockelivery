defmodule Rockelivery.UserTest do
  use Rockelivery.DataCase, async: true

  import Rockelivery.Factory

  alias Ecto.Changeset
  alias Rockelivery.User

  describe "changeset/2" do
    test "when all params are valid, returns a valid changeset" do
      params = build(:user_params)

      response = User.changeset(params)

      assert %Changeset{changes: %{name: "Hugo"}, valid?: true} = response
    end

    test "when updating a changeset, return a valid changeset with changes" do
      params = build(:user_params)

      changeset = User.changeset(params)

      changes = %{"name" => "Hugo Lacerda", "email" => "hugolac@fmail.com"}

      response = User.changeset(changeset, changes)

      assert %Changeset{
               changes: %{name: "Hugo Lacerda", email: "hugolac@fmail.com"},
               valid?: true
             } = response
    end

    test "when there are any invalid parameter, return an ivalid changeset" do
      params = build(:user_params, %{"age" => 16, "password" => "1234"})

      response = User.changeset(params)

      expected = %{
        age: ["must be greater than or equal to 18"],
        password: ["should be at least 6 character(s)"]
      }

      assert errors_on(response) == expected
    end
  end
end
