defmodule ReciperiWeb.Schema.Scalars do
  @moduledoc false

  use Absinthe.Schema.Notation

  @desc """
  This scalar type represents time values provided in the ISOz datetime format
  (that is, the ISO 8601 format without the timezone offset, e.g.,
  "2015-06-24T04:50:34Z").
  """
  scalar :time do
    parse fn %{value: value} ->
      case Timex.parse(value, "{ISO:Extended:Z}") do
        {:ok, date} -> {:ok, date}
        _ -> :error
      end
    end

    serialize(&Timex.format!(&1, "{ISO:Extended:Z}"))
  end

  scalar :decimal do parse fn
    %{value: value}, _ -> Decimal.parse(value)
    _, _ ->
      :error
  end
    serialize &to_string/1
  end

  @desc """
  This scalar type represents time values as a Unix timestamp (in milliseconds).
  """
  scalar :timestamp do
    parse(fn %{value: value} ->
      {:ok, Timex.from_unix(value, :millisecond)}
    end)

    serialize(fn time ->
      DateTime.to_unix(Timex.to_datetime(time), :millisecond)
    end)
  end
end
