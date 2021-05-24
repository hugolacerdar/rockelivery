defmodule RockeliveryWeb.UsersControllerTest do
  use RockeliveryWeb.ConnCase, async: true

  import Rockelivery.Factory

  describe "create/2" do
    test "when all params are valid, creates the user", %{conn: conn} do
      params = build(:user_params)

      response =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:created)

      assert %{
               "message" => "User created successfully!",
               "user" => %{
                 "address" => "Rua 2",
                 "age" => 26,
                 "cpf" => "12345678923",
                 "email" => "hugo@mailc.com",
                 "id" => _id,
                 "name" => "Hugo"
               }
             } = response
    end

    test "when there is any error, returns errors", %{conn: conn} do
      params = %{"password" => "12", "name" => "Hufo"}

      response =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:bad_request)

      expected = %{
        "message" => %{
          "address" => ["can't be blank"],
          "age" => ["can't be blank"],
          "cep" => ["can't be blank"],
          "cpf" => ["can't be blank"],
          "email" => ["can't be blank"],
          "password" => ["should be at least 6 character(s)"]
        }
      }

      assert response == expected
    end
  end

  describe "delete/2" do
    test "when there is a user with the given id, deletes the user", %{conn: conn} do
      id = "2a723b3f-8850-452c-bdbf-28b81edefd32"
      insert(:user)

      response =
        conn
        |> delete(Routes.users_path(conn, :delete, id))
        |> response(:no_content)

      assert response == ""
    end
  end
end
