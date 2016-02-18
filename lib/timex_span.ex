defmodule TimexSpan do
  use Timex

  @type span :: struct

  defstruct years: 0,
            weeks: 0,
            days: 0,
            hours: 0,
            mins: 0,
            secs: 0

  def to_keyword_list(span) do
    span |> Map.from_struct |> Map.to_list
  end

  def negate(%TimexSpan{years: years, days: days, weeks: weeks,
    hours: hours, mins: mins, secs: secs}) do

    %TimexSpan{years: -years, days: -days, weeks: -weeks,
      hours: -hours, mins: -mins, secs: -secs}
  end

  @doc """

  Create a span of years equal to the specified number.  Optionally
  adds or replaces the *year* component of a span passed in as its
  second argument.

  ## Examples

      iex> TimexSpan.years(4)
      %TimexSpan{years: 4}

      iex> span = %TimexSpan{years: 3, weeks: 2}
      iex> TimexSpan.years(4, span)
      %TimexSpan{years: 4, weeks: 2}

  """
  @spec years(number, span) :: span
  def years(num_years, span \\ %TimexSpan{}) when is_number(num_years) do
    %{span | years: num_years}
  end

  @doc """

  Create a span of weeks equal to the specified number.  Optionally
  adds or replaces the *week* component of a span passed in as its
  second argument.

  ## Examples

      iex> TimexSpan.weeks(4)
      %TimexSpan{weeks: 4}

      iex> span = %TimexSpan{weeks: 3, secs: 2}
      iex> TimexSpan.weeks(4, span)
      %TimexSpan{weeks: 4, secs: 2}

  """
  @spec weeks(number, span) :: span
  def weeks(num_weeks, span \\ %TimexSpan{}) when is_number(num_weeks) do
    %{span | weeks: num_weeks}
  end

  @doc """

  Create a span of days equal to the specified number.  Optionally
  adds or replaces the *day* component of a span passed in as its
  second argument.

  ## Examples

      iex> TimexSpan.days(4)
      %TimexSpan{days: 4}

      iex> span = %TimexSpan{days: 3, secs: 2}
      iex> TimexSpan.days(4, span)
      %TimexSpan{days: 4, secs: 2}

  """
  @spec days(number, span) :: span
  def days(num_days, span \\ %TimexSpan{}) when is_number(num_days) do
    %{span | days: num_days}
  end

  @doc """

  Create a span of hours equal to the specified number.  Optionally
  adds or replaces the *hour* component of a span passed in as its
  second argument.

  ## Examples

      iex> TimexSpan.hours(4)
      %TimexSpan{hours: 4}

      iex> span = %TimexSpan{hours: 3, secs: 2}
      iex> TimexSpan.hours(4, span)
      %TimexSpan{hours: 4, secs: 2}

  """
  @spec hours(number, span) :: span
  def hours(num_hours, span \\ %TimexSpan{}) when is_number(num_hours) do
    %{span | hours: num_hours}
  end

  @doc """

  Create a span of mins equal to the specified number.  Optionally
  adds or replaces the *min* component of a span passed in as its
  second argument.

  ## Examples

      iex> TimexSpan.mins(4)
      %TimexSpan{mins: 4}

      iex> span = %TimexSpan{mins: 3, secs: 2}
      iex> TimexSpan.mins(4, span)
      %TimexSpan{mins: 4, secs: 2}

  """
  @spec mins(number, span) :: span
  def mins(num_mins, span \\ %TimexSpan{}) when is_number(num_mins) do
    %{span | mins: num_mins}
  end

  @doc """

  Create a span of secs equal to the specified number.  Optionally
  adds or replaces the *sec* component of a span passed in as its
  second argument.

  ## Examples

      iex> TimexSpan.secs(4)
      %TimexSpan{secs: 4}

      iex> span = %TimexSpan{hours: 1, secs: 3}
      iex> TimexSpan.secs(4, span)
      %TimexSpan{hours: 1, secs: 4}

  """
  @spec secs(number, span) :: span
  def secs(num_secs, span \\ %TimexSpan{}) when is_number(num_secs) do
    %{span | secs: num_secs}
  end

  @doc """

  Return a DateTime that is earlier than the given datetime by 
  the given span.  

  ## Examples

      iex> span = TimexSpan.years(5)
      iex> date = Timex.Date.from({{2015, 6, 24}, {14, 27, 52}})
      iex> %Timex.DateTime{year: year} = TimexSpan.before(span, date)
      iex> year
      2010

      iex> import TimexSpan
      iex> date = Timex.Date.from({{2015, 6, 24}, {14, 27, 52}})
      iex> 5 |> years |> before(date)
      %Timex.DateTime{calendar: :gregorian, day: 24, hour: 14, minute: 27, month: 6,
       ms: 0, second: 52,
       timezone: %Timex.TimezoneInfo{abbreviation: "UTC", from: :min,
        full_name: "UTC", offset_std: 0, offset_utc: 0, until: :max}, year: 2010}
  """
  @spec before(span, date :: DateTime.t) :: DateTime.t
  def before(span, date) do
    keywords = span
                |> negate
                |> to_keyword_list
    Date.shift(date, keywords)
  end

  @doc """

  Return a DateTime that is later than the given datetime by 
  the given span.  

  ## Examples

      iex> span = TimexSpan.years(5)
      iex> date = Timex.Date.from({{2015, 6, 24}, {14, 27, 52}})
      iex> TimexSpan.from(span, date)
      %Timex.DateTime{calendar: :gregorian, day: 24, hour: 14, minute: 27, month: 6,
       ms: 0, second: 52,
       timezone: %Timex.TimezoneInfo{abbreviation: "UTC", from: :min,
        full_name: "UTC", offset_std: 0, offset_utc: 0, until: :max}, year: 2020}

      iex> import TimexSpan
      iex> date = Timex.Date.from({{2015, 6, 24}, {14, 27, 52}})
      iex> 5 |> years |> from(date)
      %Timex.DateTime{calendar: :gregorian, day: 24, hour: 14, minute: 27, month: 6,
       ms: 0, second: 52,
       timezone: %Timex.TimezoneInfo{abbreviation: "UTC", from: :min,
        full_name: "UTC", offset_std: 0, offset_utc: 0, until: :max}, year: 2020}
  """
  @spec from(span, date :: DateTime.t) :: DateTime.t
  def from(span, date) do
    keywords = span |> to_keyword_list
    Date.shift(date, keywords)
  end

  @doc """

  Return a DateTime that is earlier than the current datetime by 
  the given span. Equivalent to calling `before(Timex.Date.now)`

  """
  @spec ago(span) :: DateTime.t
  def ago(span) do
    before(span, Date.now)
  end

end
