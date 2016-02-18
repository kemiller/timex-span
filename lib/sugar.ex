defmodule TimexSugar do
  use Timex


  defmodule Span do
    defstruct years: 0,
              weeks: 0,
              days: 0,
              hours: 0,
              mins: 0,
              secs: 0

    def to_keyword_list(span) do
      span |> Map.from_struct |> Map.to_list
    end

    def negate(%Span{years: years, days: days, weeks: weeks,
      hours: hours, mins: mins, secs: secs}) do

      %Span{years: -years, days: -days, weeks: -weeks,
        hours: -hours, mins: -mins, secs: -secs}
    end
  end

  @doc """

  Create a span of years equal to the specified number.  Optionally
  adds or replaces the *year* component of a span passed in as its
  second argument.

  ## Examples

      iex> #{__MODULE__}.years(4)
      %#{__MODULE__}.Span{years: 4}

      iex> span = %#{__MODULE__}.Span{years: 3, weeks: 2}
      iex> #{__MODULE__}.years(4, span)
      %#{__MODULE__}.Span{years: 4, weeks: 2}

  """
  @spec years(number, span :: Span.t) :: Span.t
  def years(num_years, span \\ %Span{}) when is_number(num_years) do
    %{span | years: num_years}
  end

  @doc """

  Create a span of weeks equal to the specified number.  Optionally
  adds or replaces the *week* component of a span passed in as its
  second argument.

  ## Examples

      iex> #{__MODULE__}.weeks(4)
      %#{__MODULE__}.Span{weeks: 4}

      iex> span = %#{__MODULE__}.Span{weeks: 3, secs: 2}
      iex> #{__MODULE__}.weeks(4, span)
      %#{__MODULE__}.Span{weeks: 4, secs: 2}

  """
  @spec weeks(number, span :: Span.t) :: Span.t
  def weeks(num_weeks, span \\ %Span{}) when is_number(num_weeks) do
    %{span | weeks: num_weeks}
  end

  @doc """

  Create a span of days equal to the specified number.  Optionally
  adds or replaces the *day* component of a span passed in as its
  second argument.

  ## Examples

      iex> #{__MODULE__}.days(4)
      %#{__MODULE__}.Span{days: 4}

      iex> span = %#{__MODULE__}.Span{days: 3, secs: 2}
      iex> #{__MODULE__}.days(4, span)
      %#{__MODULE__}.Span{days: 4, secs: 2}

  """
  @spec days(number, span :: Span.t) :: Span.t
  def days(num_days, span \\ %Span{}) when is_number(num_days) do
    %{span | days: num_days}
  end

  @doc """

  Create a span of hours equal to the specified number.  Optionally
  adds or replaces the *hour* component of a span passed in as its
  second argument.

  ## Examples

      iex> #{__MODULE__}.hours(4)
      %#{__MODULE__}.Span{hours: 4}

      iex> span = %#{__MODULE__}.Span{hours: 3, secs: 2}
      iex> #{__MODULE__}.hours(4, span)
      %#{__MODULE__}.Span{hours: 4, secs: 2}

  """
  @spec hours(number, span :: Span.t) :: Span.t
  def hours(num_hours, span \\ %Span{}) when is_number(num_hours) do
    %{span | hours: num_hours}
  end

  @doc """

  Create a span of mins equal to the specified number.  Optionally
  adds or replaces the *min* component of a span passed in as its
  second argument.

  ## Examples

      iex> #{__MODULE__}.mins(4)
      %#{__MODULE__}.Span{mins: 4}

      iex> span = %#{__MODULE__}.Span{mins: 3, secs: 2}
      iex> #{__MODULE__}.mins(4, span)
      %#{__MODULE__}.Span{mins: 4, secs: 2}

  """
  @spec mins(number, span :: Span.t) :: Span.t
  def mins(num_mins, span \\ %Span{}) when is_number(num_mins) do
    %{span | mins: num_mins}
  end

  @doc """

  Create a span of secs equal to the specified number.  Optionally
  adds or replaces the *sec* component of a span passed in as its
  second argument.

  ## Examples

      iex> #{__MODULE__}.secs(4)
      %#{__MODULE__}.Span{secs: 4}

      iex> span = %#{__MODULE__}.Span{hours: 1, secs: 3}
      iex> #{__MODULE__}.secs(4, span)
      %#{__MODULE__}.Span{hours: 1, secs: 4}

  """
  @spec secs(number, span :: Span.t) :: Span.t
  def secs(num_secs, span \\ %Span{}) when is_number(num_secs) do
    %{span | secs: num_secs}
  end

  @doc """

  Return a DateTime that is earlier than the given datetime by 
  the given span.  

  ## Examples

      iex> span = #{__MODULE__}.years(5)
      iex> date = Timex.Date.from({{2015, 6, 24}, {14, 27, 52}})
      iex> #{__MODULE__}.before(span, date)
      %Timex.DateTime{calendar: :gregorian, day: 24, hour: 14, minute: 27, month: 6,
       ms: 0, second: 52,
       timezone: %Timex.TimezoneInfo{abbreviation: "UTC", from: :min,
        full_name: "UTC", offset_std: 0, offset_utc: 0, until: :max}, year: 2010}

      iex> import TimexSugar
      iex> date = Timex.Date.from({{2015, 6, 24}, {14, 27, 52}})
      iex> 5 |> years |> before(date)
      %Timex.DateTime{calendar: :gregorian, day: 24, hour: 14, minute: 27, month: 6,
       ms: 0, second: 52,
       timezone: %Timex.TimezoneInfo{abbreviation: "UTC", from: :min,
        full_name: "UTC", offset_std: 0, offset_utc: 0, until: :max}, year: 2010}
  """
  @spec before(span :: Span.t, date :: DateTime.t) :: DateTime.t
  def before(span, date) do
    keywords = span
                |> Span.negate
                |> Span.to_keyword_list
    Date.shift(date, keywords)
  end

  @doc """

  Return a DateTime that is later than the given datetime by 
  the given span.  

  ## Examples

      iex> span = #{__MODULE__}.years(5)
      iex> date = Timex.Date.from({{2015, 6, 24}, {14, 27, 52}})
      iex> #{__MODULE__}.from(span, date)
      %Timex.DateTime{calendar: :gregorian, day: 24, hour: 14, minute: 27, month: 6,
       ms: 0, second: 52,
       timezone: %Timex.TimezoneInfo{abbreviation: "UTC", from: :min,
        full_name: "UTC", offset_std: 0, offset_utc: 0, until: :max}, year: 2020}

      iex> import TimexSugar
      iex> date = Timex.Date.from({{2015, 6, 24}, {14, 27, 52}})
      iex> 5 |> years |> from(date)
      %Timex.DateTime{calendar: :gregorian, day: 24, hour: 14, minute: 27, month: 6,
       ms: 0, second: 52,
       timezone: %Timex.TimezoneInfo{abbreviation: "UTC", from: :min,
        full_name: "UTC", offset_std: 0, offset_utc: 0, until: :max}, year: 2020}
  """
  @spec from(span :: Span.t, date :: DateTime.t) :: DateTime.t
  def from(span, date) do
    keywords = span |> Span.to_keyword_list
    Date.shift(date, keywords)
  end

  @doc """

  Return a DateTime that is earlier than the current datetime by 
  the given span. Equivalent to calling `before(Timex.Date.now)`

  """
  @spec ago(span :: Span.t) :: DateTime.t
  def ago(span) do
    before(span, Date.now)
  end

end
