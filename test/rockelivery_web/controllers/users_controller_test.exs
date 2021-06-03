defmodule RockeliveryWeb.UsersControllerTest do
  use RockeliveryWeb.ConnCase, async: true

  import Mox
  import Rockelivery.Factory

  alias RockeliveryWeb.Auth.Guardian

  describe "create/2" do
    test "when all params are valid, creates the user", %{conn: conn} do
      params = build(:user_params)

      expect(Rockelivery.ViaCep.ClientMock, :get_cep_info, fn _cep ->
        {:ok, build(:cep_info)}
      end)

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
    setup %{conn: conn} do
      user = insert(:user)
      {:ok, token, _claims} = Guardian.encode_and_sign(user)

      conn = put_req_header(conn, "authorization", "Bearer #{token}")

      {:ok, conn: conn, user: user}
    end

    test "when there is a user with the given id, deletes the user", %{conn: conn} do
      id = "2a723b3f-8850-452c-bdbf-28b81edefd32"

      response =
        conn
        |> delete(Routes.users_path(conn, :delete, id))
        |> response(:no_content)

      assert response == ""
    end

    test "when id doesn't exist, returns an error", %{conn: conn} do
      id = "2a723b3f-8850-452c-bdbf-28381edEfd32"

      response =
        conn
        |> delete(Routes.users_path(conn, :delete, id))
        |> json_response(:not_found)

      assert %{"message" => "User not found"} == response
    end
  end

  describe "update/2" do
    setup %{conn: conn} do
      user = insert(:user)
      {:ok, token, _claims} = Guardian.encode_and_sign(user)

      conn = put_req_header(conn, "authorization", "Bearer #{token}")

      {:ok, conn: conn, user: user}
    end

    test "when there is a user with the given id and params are valid, updates the user", %{
      conn: conn
    } do
      id = "2a723b3f-8850-452c-bdbf-28b81edefd32"

      params = %{"email" => "hero@cmail.com"}

      response =
        conn
        |> put(Routes.users_path(conn, :update, id, params))
        |> response(:ok)

      assert %{
               "user" => %{
                 "address" => "Rua 2",
                 "age" => 26,
                 "cpf" => "12345678923",
                 "email" => "hero@cmail.com",
                 "name" => "Hugo",
                 "id" => "2a723b3f-8850-452c-bdbf-28b81edefd32"
               }
             } == Jason.decode!(response)
    end

    test "when there is a user with the given id and any of the params is invalid, returns an error",
         %{
           conn: conn
         } do
      id = "2a723b3f-8850-452c-bdbf-28b81edefd32"

      params = %{"email" => "herocmail.com"}

      response =
        conn
        |> put(Routes.users_path(conn, :update, id, params))
        |> response(:bad_request)

      assert %{"message" => %{"email" => ["has invalid format"]}} == Jason.decode!(response)
    end

    test "when id doesn't exist, returns an error", %{conn: conn} do
      id = "2a723b3f-8850-452c-bdbf-28381edEfd32"

      response =
        conn
        |> put(Routes.users_path(conn, :update, id))
        |> json_response(:not_found)

      assert %{"message" => "User not found"} == response
    end
  end

  describe "show/2" do
    setup %{conn: conn} do
      user = insert(:user)
      {:ok, token, _claims} = Guardian.encode_and_sign(user)

      conn = put_req_header(conn, "authorization", "Bearer #{token}")

      {:ok, conn: conn, user: user}
    end

    test "when id exists, return the user", %{conn: conn} do
      id = "2a723b3f-8850-452c-bdbf-28b81edefd32"

      response =
        conn
        |> get(Routes.users_path(conn, :show, id))
        |> json_response(:ok)

      expected = %{
        "user" => %{
          "email" => "hugo@mailc.com",
          "address" => "Rua 2",
          "age" => 26,
          "cpf" => "12345678923",
          "id" => "2a723b3f-8850-452c-bdbf-28b81edefd32",
          "name" => "Hugo"
        }
      }

      assert response == expected
    end

    test "when id doesn't exist, returns an error", %{conn: conn} do
      id = "2a723b3f-8850-452c-bdbf-28381edEfd32"

      response =
        conn
        |> get(Routes.users_path(conn, :show, id))
        |> json_response(:not_found)

      assert %{"message" => "User not found"} == response
    end
  end
end
