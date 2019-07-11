---

copyright:
  years: 2019
lastupdated: "2019-06-06"

keywords: SQL query, time series, SQL, artifact creation, function

subcollection: sql-query

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

# Artifact creation functions
{: #artifact}

Each of these functions produces, as its output, a time series or some other artifact that some
[data processing functions](/docs/services/sql-query?topic=sql-query-data_processing_functions) require as input.

## Time series creation functions
{: #ts_creation}

Each of these functions converts data in table columns into a *time series* artifact.

**TIME_SERIES(String, String)**  
Output: DoubleTimeSeries  
Creates a DoubleTimeSeries that does not use a [TRS](/docs/services/sql-query?topic=sql-query-TRS). The resulting timeticks are unitless, and there is no start time.
- The first parameter specifies the name of a table column containing numeric data that represents the timeticks of the observations.
- The second parameter specifies the name of the table column containing data of type Double that represents the values of the observations.

**TIME_SERIES_WITH_TRS(String, String, TRS)**  
Output: DoubleTimeSeries  
Creates a DoubleTimeSeries that uses a custom [TRS](/docs/services/sql-query?topic=sql-query-TRS).
- The first parameter specifies the name of a table column containing numeric data that represents the timeticks of the observations.
- The second parameter specifies the name of the table column containing data of type Double that represents the values of the observations.
- The third parameter specifies the name of the TRS that is to be associated with the time series. This TRS determines the granularity and start time of the time series timeticks.

**TIME_SERIES_DA(DoubleArrayTimeSeries)**  
Output: DoubleArrayTimeSeries  
Creates a DoubleArrayTimeSeries that does not use a [TRS](/docs/services/sql-query?topic=sql-query-TRS). The resulting timeticks are unitless, and there is no start time.
- The first parameter specifies the name of a table column containing numeric data that represents the timeticks of the observations.
- The second parameter specifies the name of the table column containing data of type DoubleArray that represents the values of the observations.

**TIME_SERIES_DA_WITH_TRS(String, String, TRS)**  
Output: DoubleArrayTimeSeries  
Creates a DoubleArrayTimeSeries that uses a custom [TRS](/docs/services/sql-query?topic=sql-query-TRS).
- The first parameter specifies the name of a table column containing numeric data that represents the timeticks of the observations.
- The second parameter specifies the name of the table column containing data of type DoubleArray that represents the values of the observations.
- The third parameter specifies the name of the TRS that is to be associated with the time series. This TRS determines the granularity and start time of the time series timeticks.

**TIME_SERIES_S(String, String)**  
Output: StringTimeSeries  
Creates a StringTimeSeries that does not use a [TRS](/docs/services/sql-query?topic=sql-query-TRS). The resulting timeticks are unitless, and there is no start time.
- The first parameter specifies the name of a table column containing numeric data that represents the timeticks of the observations.
- The second parameter specifies the name of the table column containing data of type String that represents the values of the observations.

**TIME_SERIES_S_WITH_TRS(String, String, TRS)**  
Output: StringTimeSeries  
Creates a StringTimeSeries that uses a custom [TRS](/docs/services/sql-query?topic=sql-query-TRS).
- The first parameter specifies the name of a table column containing numeric data that represents the timeticks of the observations.
- The second parameter specifies the name of the table column containing data of type String that represents the values of the observations.
- The third parameter specifies the name of the TRS that is to be associated with the time series. This TRS determines the granularity and start time of the time series timeticks.

**TIME_SERIES_SA(String, String)**  
Output: StringArrayTimeSeries  
Creates a StringArrayTimeSeries that does not use a [TRS](/docs/services/sql-query?topic=sql-query-TRS). The resulting timeticks are unitless, and there is no start time.
- The first parameter specifies the name of a table column containing numeric data that represents the timeticks of the observations.
- The second parameter specifies the name of the table column containing data of type StringArray that represents the values of the observations.

**TIME_SERIES_SA_WITH_TRS(String, String, TRS)**  
Output: StringArrayTimeSeries  
Creates a StringArrayTimeSeries that uses a custom [TRS](/docs/services/sql-query?topic=sql-query-TRS).
- The first parameter specifies the name of a table column containing numeric data that represents the timeticks of the observations.
- The second parameter specifies the name of the table column containing data of type StringArray that represents the values of the observations.
- The third parameter specifies the name of the TRS that is to be associated with the time series. This TRS determines the granularity and start time of the time series
timeticks.

## TRS creation functions
{: #trs_creation}

These functions create or reassign a [time reference system (TRS)](/docs/services/sql-query?topic=sql-query-TRS).

**TS_TRS(String, TimestampType) or TS_TRS(String, String)**  
Output: TRS  
Creates a TRS that determines the granularity and start time of a time series.
- The first parameter specifies the granularity of the TRS. It can be specified using any of the formats accepted by the Java [parse function of the Duration class](https://docs.oracle.com/javase/8/docs/api/java/time/Duration.html#parse-java.lang.CharSequence-).
- The second parameter specifies the start time of the TRS. It can be specified either as a TimestampType or as a string that uses any of the formats accepted by the Java [DateTimeFormatter class](https://docs.oracle.com/javase/8/docs/api/java/time/format/DateTimeFormatter.html).

**TS_TRS_DEFAULT()**  
Output: TRS  
Creates a default TRS that determines the granularity and start time of a time series.
- The granularity is 'PT0.001S' (1 millisecond).
- The start time is '1970-01-01T00:00:00'.

**TS_TRS_DEFAULT_STARTTIME(String)**  
Output: TRS  
Creates a TRS that determines the granularity and start time of a time series.
- The parameter specifies the granularity of the TRS. It can be specified using any of the formats accepted by the Java [parse function of the Duration class](https://docs.oracle.com/javase/8/docs/api/java/time/Duration.html#parse-java.lang.CharSequence-).
- The start time is '1970-01-01T00:00:00'.

**TS_WITH_TRS(*TimeSeries*, TRS)**  
Output: *TimeSeries* 
Changes the TRS that is associated with the specified time series. If the specified time series is not already associated with a TRS, this function throws an exception.

## Combiner creation functions
{: #combiner_creation}

Each of these functions creates a *combiner* artifact, which is used by other functions to determine how to treat observations that have identical timeticks.

**TS_COMBINER_CONCATENATE(String)**  
Output: CombinerType  
Creates a combiner that instructs another function to combine, into a single observation, observations that have identical timeticks. The value of the new observation is the concatenation of the original values. The values are separated by the specified character (if any), which acts as a delimiter.

**TS_COMBINER_ADD()**  
Output: CombinerType  
Creates a combiner that instructs another function to combine, into a single observation, observations that have values of type Double and identical timeticks. The value of the new observation is the sum of the original values.

**TS_COMBINER_MUL()**  
Output: CombinerType  
Creates a combiner that instructs another function to combine, into a single observation, observations that have values of type Double and identical timeticks. The value of the new observation is the result of multiplying the original values.

**TS_COMBINER_MIN()**  
Output: CombinerType  
Creates a combiner that instructs another function to combine, into a single observation, observations that have values of type Double and identical timeticks. The value of the new observation is the minimum of the original values.

**TS_COMBINER_MAX()**  
Output: CombinerType  
Creates a combiner that instructs another function to combine, into a single observation, observations that have values of type Double and identical timeticks. The value of the new observation is the maximum of the original values.

**TS_COMBINER_AVG()**  
Output: CombinerType  
Creates a combiner that instructs another function to combine, into a single observation, observations that have values of type Double and identical timeticks. The value of the new observation is the average of the original values.

**TS_COMBINER_FIRST()**  
Output: CombinerType  
Creates a combiner that instructs another function to combine, into a single observation, observations that have identical timeticks. The value of the new observation is the first of the original values.

**TS_COMBINER_LAST()**  
Output: CombinerType  
Creates a combiner that instructs another function to combine, into a single observation, observations that have identical timeticks. The value of the new observation is the last of the original values.

## Interpolator creation functions  
{: #interpolator_creation}

Each of these functions generates an *interpolator* artifact, which is used by cleaning functions to replace null values, and by resampling, join, and align functions to calculate values for generated observations.

**TS_INTERPOLATOR_FILL(see below<sup>2</sup>)**  
Output: InterpolatorType  
Creates an interpolator that replaces any null value with the specified value.

**TS_INTERPOLATOR_NEAREST(see below<sup>2</sup>)**  
Output: InterpolatorType  
Creates an interpolator that replaces a null value with the value of the neighboring observation that has the nearest timetick. If the value of that observation is also null, the original null value remains unchanged. If the previous and next timeticks are equidistant, the value of the observation with the previous timetick is used. If no nearest observation exists (that is, if the input time series contains a single observation), this function replaces the null value with the specified value.

**TS_INTERPOLATOR_NEXT(see below<sup>2</sup>)**  
Output: InterpolatorType  
Creates an interpolator that replaces a null value with the next value in the time series. If no such value exists, it fills the null value with the specified value.

**TS_INTERPOLATOR_PREV(see below<sup>2</sup>)**  
Output: InterpolatorType  
Creates an interpolator that replaces a null value with the previous value. If there is no previous value, it fills the null value with the specified value.

**TS_INTERPOLATOR_LINEAR(see below<sup>2</sup>, Integer, Integer)**  
Output: InterpolatorType  
Creates an interpolator that replaces a null value with a value that is calculated by [linear interpolation](https://en.wikipedia.org/wiki/Linear_interpolation) based on the specified number of previous (second parameter) and subsequent (third parameter) observations (both numbers must be positive). The value of the first parameter is used as a filler value when there are not enough previous or subsequent values to satisfy parameter 2 or 3. For example, if `TS_INTERPOLATOR_LINEAR(9.76, 3, 5)` is specified, for each null value, a line is calculated using the 3 previous and 5 subsequent data points that minimizes the average error for all 8 data points, and the point on this line that corresponds to the timetick of the null value determines the filler value. If 3 previous or 5 subsequent data points are not available, the value 9.76 is used as the filler value.

**TS_INTERPOLATOR_SPLINE(see below<sup>2</sup>, Integer, Integer)**  
Output: InterpolatorType  
Creates an interpolator that replaces a null value with a value that is calculated by [spline interpolation](https://en.wikipedia.org/wiki/Spline_interpolation) based on the specified number of previous (second parameter) and subsequent (third parameter) observations (both numbers must be positive). The value of the first parameter is used as a filler value when there are not enough previous or subsequent values to satisfy parameter 2 or 3. For example, if `TS_INTERPOLATOR_SPLINE(3, 5, 9.76)` is specified, for each null value, a spline is calculated using the 3 previous and 5 subsequent data points that minimizes the average error for all 8 data points, and the point on this spline that corresponds to the timetick of the null value determines the filler value. If 3 previous or 5 subsequent data points are not available, the value 9.76 is used as the filler value.

**<sup>2</sup> The input type can be any of String, Double, Array[String], Array[Double], but must be of a type that corresponds to the type of the time series.**

## Anchor creation functions  
{: #anchor_creation}

Each of these functions creates an *anchor* artifact, which is used by other functions to determine where to segment a time series.

**TS_ANCHOR_EQ(see below<sup>3</sup>)**  
Output: AnchorType  
Creates an anchor that sets an anchor point when an observation value equals the value of the input parameter.

**TS_ANCHOR_CONTAINS(String)**  
Output: AnchorType  
Creates an anchor that sets an anchor point when an input string is contained in the value of an observation value.

**TS_ANCHOR_CONTAINED_IN(String)**  
Output: AnchorType  
Creates an anchor that sets an anchor point when an observation value is contained in the input string.

**TS_ANCHOR_STARTS_WITH(String)**  
Output: AnchorType  
Creates an anchor that sets an anchor point when an observation value begins with the input string.

**TS_ANCHOR_ENDS_WITH(String)**  
Output: AnchorType  
Creates an anchor that sets an anchor point when an observation value ends with the input string.

**TS_ANCHOR_GT(Double)**  
Output: AnchorType  
Creates an anchor that sets an anchor point when an observation value is greater than (>) the input value.

**TS_ANCHOR_GTE(Double)**  
Output: AnchorType  
Creates an anchor that sets an anchor point when an observation value is greater than or equal to (>=) the input value.

**TS_ANCHOR_LT(Double)**  
Output: AnchorType  
Creates an anchor that sets an anchor point when an observation value is less than (<) the input value.

**TS_ANCHOR_LTE(Double)**  
Output: AnchorType  
Creates an anchor that sets an anchor point when an observation value is less than or equal to (<=) the input value.

**TS_ANCHOR_DIVISIBLE_BY(Double)**  
Output: AnchorType  
Creates an anchor that sets an anchor point when an observation value is evenly divisible (that is, divisible with no remainder) by the input value.

**TS_ANCHOR_AND(AnchorType, AnchorType)**  
Output: AnchorType  
Creates an anchor that sets an anchor point only when both of the specified anchors would set an anchor point independently.

**TS_ANCHOR_OR(AnchorType, AnchorType)**  
Output: AnchorType  
Creates an anchor that sets an anchor point only when either of the specified anchors would set an anchor point independently.

**TS_ANCHOR_NOT(AnchorType)**  
Output: AnchorType  
Creates an anchor that sets an anchor point when the specified anchor would not.

**TS_ANCHOR_INDEX(AnchorType, Integer)**  
Output: AnchorType  
Creates, for use by an array time series, an anchor of the specified type (first parameter) for a the specified index (second parameter) of the series.

**<sup>3</sup> The input type can be any of String, Double, Array[String], Array[Double]**

## Forecasting model creation functions
{: #forecasting_model_creation}

Each of these functions creates a *forecasting model* artifact, which is used by other functions for forecasting and anomaly detection.

**TS_FORECAST_BATS(Integer, Boolean)**  
Output: ForecastingModel  
Creates a forecasting model with Box-Cox, ARMA, trend, and seasonal (BATS) components. The value of the first parameter specifies the minimum number of training observations. The value of the second parameter specifies whether the Box-Cox transformation is to be used:
- Specify **1** if the Box-Cox transformation is to be used.
- Specify **0** if the Box-Cox transformation is not to be used.

**TS_FORECAST_HWS(Integer, Integer)**  
Output: ForecastingModel  
Creates a Holt-Winters forecasting model with the specified number of observations per season (first parameter) and minimum number of training seasons (second parameter).

**TS_FORECAST_ARIMA(Integer)**  
Output: ForecastingModel  
Creates an ARIMA forecasting model with the with the specified minimum number of training observations.

**TS_FORECAST_ARMA(Integer)**  
Output: ForecastingModel  
Creates an ARMA forecasting model with the with the specified minimum number of training observations.

**TS_FORECAST_LINEAR(Integer, Integer)**  
Output: ForecastingModel  
Creates an ordinary least squares (OLS) linear regression forecasting model.
- The first parameter specifies the number of observations that are to be used to initialize the model (that is, to calculate its slope and intercept). If the model is not to be initialized, specify -1.
- The second parameter specifies the minimum number of previous values used to compute each new slope and intercept. This must be at least 2. 

**TS_FORECAST_AVERAGE(Integer, Integer)**  
Output: ForecastingModel  
Creates a forecasting model that returns the running average of the sample data as its forecast value.
- The first parameter specifies the number of observations that are to be used to initialize the model (that is, to calculate its average). If the model is not to be initialized, specify -1.
- The second parameter specifies the minimum number of previous values used to compute each new average. This must be at least 2.

**TS_FORECAST_AUTO(Integer)**  
Output: ForecastingModel  
Creates a forecasting model that dynamically chooses, from among the following forecasting algorithms, the algorithm that returns the fewest errors:
- HW additive
- HW multiplicative
- ARIMA
- OLS linear regression
- BATS

The parameter specifies the minimum number of training observations.

## Matcher creation functions
{: #matcher_creation}

Each of these functions creates a *matcher* artifact, which is used by a [matching function](/docs/services/sql-query?topic=sql-query-string_matching) to determine which observations of a string time series satisfy a particular pattern. The matching function specifies a matcher, a pattern, and the time series to which the pattern is to be compared.

**TS_MATCHER_SEQ()**  
Output: MatcherType  
Creates a matcher that matches an array of string values (the *pattern*) with an entire string time series exactly and in sequence. If the pattern and time series match, the function that uses the matcher returns the input time series; otherwise, the function returns null. This corresponds to using a TS_MATCHER_SUBLIST_PS matcher with a threshold of 1.

**TS_MATCHER_SUBLIST(Double)**  
Output: MatcherType  
Creates a matcher that matches an array of string values (the *pattern*) with a sublist of a string time series, to within the specified coverage threshold. The threshold is a double-precision number in the range 0.0 - 1.0 that indicates the minimum ratio of pattern size to sublist. For example, a threshold of 0.75 means that the specified pattern must match at least 75% of the time series values, in sequence and contiguously. If the threshold is met, the pattern is considered to have matched, and the function that uses the matcher returns the observations that correspond to the pattern; otherwise, the function returns null.

**TS_MATCHER_SUBSEQ_PS(Double)**  
Output: MatcherType  
Creates a matcher that matches an array of string values (the *pattern*) with a sub-sequence of a string time series, to within the specified coverage threshold. The threshold is a double-precision number in the range 0.0 - 1.0 that indicates the minimum ratio of pattern size to sequence size. For example, a threshold of 0.75 means that the specified pattern must match at least 75% of the sequence of time series values, in sequence but not necessarily contiguously. If the threshold is met, the pattern is considered to have matched, and the function that uses the matcher returns the observations that correspond to the pattern; otherwise, the function returns null.

**TS_MATCHER_SUBSEQ_PM(Double)**  
Output: MatcherType  
Creates a matcher that matches an array of string values (the *pattern*) with a sub-sequence of a string time series, to within the specified coverage threshold. The threshold is a double-precision number in the range 0.0 - 1.0 that indicates the minimum ratio of pattern size to match string size. For example, a threshold of 0.75 means that the specified pattern must match at least 75% of the match string, in sequence but not necessarily contiguously. If the threshold is met, the pattern is considered to have matched, and the function that uses the matcher returns the observations that correspond to the pattern; otherwise, the function returns null.

**TS_MATCHER_SUBSEQ_MS(Double)**  
Output: MatcherType  
Creates a matcher that matches an array of string values (the *pattern*) with a sub-sequence of a string time series, to within the specified coverage threshold. The threshold is a double-precision number in the range 0.0 - 1.0 that indicates the minimum ratio of match string size to sequence size. For example, a threshold of 0.75 means that the specified pattern must match at least 75% of the sequence of time series values. If the threshold is met, the pattern is considered to have matched the sub-sequence and the function that uses the matcher returns the observations that correspond to the match string; otherwise, the function returns null.

**TS_MATCHER_SUBSET_PS(Double)**  
Output: MatcherType  
Creates a matcher that matches an array of string values (the *pattern*) with a string time series, regardless of the order in which the items in the pattern occur in the time series. The specified coverage threshold is a double-precision number in the range 0.0 - 1.0 that indicates the minimum ratio of pattern size to sequence size. For example, a threshold of 0.75 means that the specified pattern must match at least 75% of the sequence of time series values. If the threshold is met, the pattern is considered to have matched, and the function that uses the matcher returns the observations that correspond to the pattern; otherwise, the function returns null.

**TS_MATCHER_SUBSET_PM(Double)**  
Output: MatcherType  
Creates a matcher that matches an array of string values (the *pattern*) with a string time series, regardless of the order in which the items in the pattern occur in the time series. The specified coverage threshold is a double-precision number in the range 0.0 - 1.0 that indicates the minimum ratio of pattern size to match string size. For example, a threshold of 0.75 means that the specified pattern must match at least 75% of the match string, in sequence but not necessarily contiguously. If the threshold is met, the pattern is considered to have matched, and the function that uses the matcher returns the observations that correspond to the pattern; otherwise, the function returns null.

**TS_MATCHER_SUBSET_MS(Double)**  
Output: MatcherType  
Creates a matcher that matches an array of string values (the *pattern*) with a string time series, regardless of the order in which the items in the pattern occur in the time series. The specified coverage threshold is a double-precision number in the range 0.0 - 1.0 that indicates the minimum ratio of match string size to sequence size. For example, a threshold of 0.75 means that the specified pattern must match at least 75% of the match string, in sequence but not necessarily contiguously. If the threshold is met, the pattern is considered to have matched, and the function that uses the matcher returns the observations that correspond to the match string; otherwise, the function returns null.
