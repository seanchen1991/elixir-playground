defmodule Rumbl.Category do
  use Rumbl.Web, :model

  schema "categories" do
    field :name, :string

    timestamps
  end

  @required_fields ~w(name)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end

  def alphabetical(query \\ __MODULE__) do
      from c in query, order_by: c.name
  end
end
