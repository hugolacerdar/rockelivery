defmodule Rockelivery.Item do
  use Ecto.Schema
  import Ecto.Changeset
  alias Ecto.Enum
  alias Rockelivery.Order
  @primary_key {:id, :binary_id, autogenerate: true}

  @required_params [:category, :description, :price, :photo]
  @item_category [:food, :drink, :dessert]

  @derive {Jason.Encoder, only: @required_params ++ [:id]}

  schema "items" do
    field :category, Enum, values: @item_category
    field :description, :string
    field :price, :decimal
    field :photo, :string

    many_to_many :orders, Order, join_through: "orders_items"

    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_length(:description, min: 5)
    |> validate_number(:price, greater_than: 0)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, @required_params)
  end
end
