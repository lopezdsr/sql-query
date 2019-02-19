---

copyright:
  year: 2018, 2019
lastupdated: "2018-01-30"

---

{:shortdesc: .shortdesc}
{:new_window: target="_blank"}
{:codeblock: .codeblock}
{:pre: .pre}
{:screen: .screen}
{:tip: .tip}



# TimeSeries functions

## TimeSeries Types

The following describes the various TimeSeries types supported by this package, these are UserDefinedTypes. 

| SQL type | Description |
|----------|-------------|
| DoubleTimeSeries | TimeSeries with observations of double type. |
| DoubleArrayTimeSeries | TimeSeries with observations of double array type. |
| StringTimeSeries | TimeSeries with observations of string type. |
| DoubleSegmentTimeSeries | A DoubleTimeSeries that has been segmented into windows using a segmentation function. |
| StringSegmentTimeSeries | A StringTimeSeries that has been segmented into windows using a segmentation function. |

The following table shows ways of creating the basic TimeSeries types:

| SQL TimeSeries Aggregate Function | SQL type | Description |
|---------------------|-----------|-------------|
| TIME_SERIES | DoubleTimeSeries | TimeSeries with observations of double type. |
| DA_TIME_SERIES | DoubleArrayTimeSeries | TimeSeries with observations of double array type. |
| S_TIME_SERIES | StringTimeSeries | TimeSeries with observations of String type. |


## Forecasting Types

The following describes the various Forecaster types supported by this package, these are UserDefinedTypes.

| SQL Forecaster      | SQL type | Description |
|---------------------|-----------|-------------|
| TS_FORECAST_BATS    | ForecastingModel | BATS forecasting model |
| TS_FORECAST_HWS     | ForecastingModel | Holt-Winters forecasting model |
| TS_FORECAST_ARIMA   | ForecastingModel | Arima forecasting model |
| TS_FORECAST_ARMA    | ForecastingModel | ARMA forecasting model |
| TS_FORECAST_LINEAR  | ForecastingModel | Linear forecasting model |
| TS_FORECAST_AVERAGE | ForecastingModel | Average forecasting model |
| TS_FORECAST_AUTO    | ForecastingModel | Dynamically pick best algorithm forecasting model |

## Function Types

In addition to TimeSeries Types, this library provides function types that can be used as input to various TimeSeries
functions. Currently there are 3 function types:

- *Interpolator* - Function that denotes how to find a missing value at a given timestamp.
- *Anchor* - Predicate Function that denotes if a value should be considered an anchor point. An anchor point could be thought of as a "point of interest".
- *Combiner* - Function where two given values, combine into a single value.

### Interpolator Types

| SQL Interpolator      | SQL Type | Description |
|-----------------------|-----------|-------------|
| TS_INTERPOLATOR_LINEAR | Interpolator | linear interpolator type |
| TS_INTERPOLATOR_SPLINE | Interpolator | spline interpolator type |
| TS_INTERPOLATOR_FILL | Interpolator | fill value interpolator type |
| TS_INTERPOLATOR_NEAREST | Interpolator | nearest value based on timestamp interpolator type |
| TS_INTERPOLATOR_NEXT | Interpolator | next value interpolator type |
| TS_INTERPOLATOR_PREV | Interpolator | previous value interpolator type |

### Anchor Types

| SQL Anchor   | SQL Type | Description |
|-----------------------|-----------|-------------|
| TS_ANCHOR_EQ | AnchorType | value equals predicate type |
| TS_ANCHOR_CONTAINS | AnchorType | value contains predicate type |
| TS_ANCHOR_STARTS_WITH | AnchorType | value starts with predicate type |
| TS_ANCHOR_ENDS_WITH | AnchorType | value ends with predicate type |
| TS_ANCHOR_GT | AnchorType | value greater than predicate type |
| TS_ANCHOR_GTE | AnchorType | value greater than or equal to predicate type |
| TS_ANCHOR_LT | AnchorType | value lesser than predicate type |
| TS_ANCHOR_LTE | AnchorType | value lesser than or equal to predicate type |
| TS_ANCHOR_DIVISIBLE_BY | AnchorType | value divisible by predicate type |

### Combiner Types

| SQL Combiner          | SQL Type | Description |
|-----------------------|-----------|-------------|
| TS_COMBINER_CONCATENATE | CombinerType | concatenate 2 strings function type |
| TS_COMBINER_ADD | CombinerType | add doubles function type |
| TS_COMBINER_SUB | CombinerType | subtract doubles function type |
| TS_COMBINER_MUL | CombinerType | multiply doubles function type |
| TS_COMBINER_DIV | CombinerType | divide doubles function type |
| TS_COMBINER_POW | CombinerType | power operation doubles function type |
| TS_COMBINER_MIN | CombinerType | min of doubles function type |
| TS_COMBINER_MAX | CombinerType | max of doubles function type |
| TS_COMBINER_AVG | CombinerType | average of doubles function type |

## Operations allowable on any TimeSeries

### Segmentation Functions

Segmentation functions are used to create windows over a TimeSeries.

| SQL Function | Input(s) | Output | Description |
|--------------|-------|--------|-------------|
| TS_SEGMENT(_time_series_, _window_, _step_) | DoubleTimeSeries, Int, Int | DoubleSegmentTimeSeries | Segment a TimeSeries based on record windows. |
| TS_SEGMENT_BY_TIME(_time_series_, _window_, _step_) | DoubleTimeSeries, Long, Long | DoubleSegmentTimeSeries | Segment a TimeSeries based on time windows. |
| TS_SEGMENT_BY_ANCHOR(_time_series_, _anchor_, _left_delta_, _right_delta_) | DoubleTimeSeries, AnchorType, Long, Long | DoubleSegmentTimeSeries | Segment a TimeSeries around anchor points. Anchor points are defined as those that match the anchor function. |

### Temporal Join/Align Functions

Temporal Joins can be used to join/align two different TimeSeries based on their timestamps.

| SQL Function | Input(s) | Output | Description |
|--------------|-------|--------|-------------|
| TS_INNER_JOIN(_left_time_series_, _right_time_series_) | DoubleTimeSeries, DoubleTimeSeries | DoubleArrayTimeSeries | temporally inner join 2 TimeSeries |
| TS_LEFT_JOIN(_left_time_series_, _right_time_series_, _interpolator_) | DoubleTimeSeries, DoubleTimeSeries, InterpolatorType | DoubleArrayTimeSeries | temporally left join 2 TimeSeries and interpolate missing values |
| TS_RIGHT_JOIN(_left_time_series_, _right_time_series_, _interpolator_) | DoubleTimeSeries, DoubleTimeSeries, InterpolatorType | DoubleArrayTimeSeries | temporally right join 2 TimeSeries and interpolate missing values |
| TS_LEFT_OUTER_JOIN(_left_time_series_, _right_time_series_, _interpolator_) | DoubleTimeSeries, DoubleTimeSeries, InterpolatorType | DoubleArrayTimeSeries | temporally left outer join 2 TimeSeries and interpolate missing values |
| TS_RIGHT_OUTER_JOIN(_left_time_series_, _right_time_series_, _interpolator_) | DoubleTimeSeries, DoubleTimeSeries, InterpolatorType | DoubleArrayTimeSeries | temporally left outer join 2 TimeSeries and interpolate missing values |
| TS_FULL_JOIN(_left_time_series_, _right_time_series_, _interpolator_) | DoubleTimeSeries, DoubleTimeSeries, InterpolatorType | DoubleArrayTimeSeries | temporally full join 2 TimeSeries and interpolate missing values |
| TS_INNER_ALIGN(_left_time_series_, _right_time_series_) | DoubleTimeSeries, DoubleTimeSeries | DoubleTimeSeries, DoubleTimeSeries | temporally inner align 2 TimeSeries. Unlike join, this will produce 2 TimeSeries, each of which are aligned with each other |
| TS_LEFT_ALIGN(_left_time_series_, _right_time_series_) | DoubleTimeSeries, DoubleTimeSeries | DoubleTimeSeries, DoubleTimeSeries | temporally left align 2 TimeSeries and set missing values to null. Unlike join, this will produce 2 TimeSeries, each of which are aligned with each other |
| TS_RIGHT_ALIGN(_left_time_series_, _right_time_series_) | DoubleTimeSeries, DoubleTimeSeries | DoubleTimeSeries, DoubleTimeSeries | temporally right align 2 TimeSeries and set missing values to null. Unlike join, this will produce 2 TimeSeries, each of which are aligned with each other |
| TS_FULL_ALIGN(_left_time_series_, _right_time_series_) | DoubleTimeSeries, DoubleTimeSeries | DoubleTimeSeries, DoubleTimeSeries | temporally full align 2 TimeSeries and set missing values to null. Unlike join, this will produce 2 TimeSeries, each of which are aligned with each other |
| TS_VECTOR*N*(_time_series_1_, ..., _time_series_n_) | DoubleTimeSeries* | DoubleArrayTimeSeries | temporally inner join n TimeSeries, creating a single TimeSeries of vectors |

### Interpolation Functions

Interpolation can be used to either fill missing values or resample TimeSeries at a different periodicity.

| SQL Function | Input(s) | Output | Description |
|--------------|-------|--------|-------------|
| TS_INTERPOLATE(_time_series_, _periodicity_, _interpolator_) | DoubleTimeSeries, Long, InterpolatorType | DoubleTimeSeries | interpolate the given TimeSeries |

### General Filtering Functions

General filtering operations will remove values from the TimeSeries

| SQL Function | Input(s) | Output | Description |
|--------------|-------|--------|-------------|
| TS_SLICE(_time_series_, _start_, _end_) | DoubleTimeSeries, Long, Long | DoubleTimeSeries | Create a subset of the TimeSeries from start time to end time. |
| TS_REMOVE_CONSECUTIVE_DUPLICATES(_time_series_) | DoubleTimeSeries | DoubleTimeSeries | Remove consecutive duplicate values from the TimeSeries. |
| TS_COMBINE_DUPLICATE_TIMESTAMPS(_time_series_, _combiner_) | DoubleTimeSeries, CombinerType | DoubleTimeSeries | Combine duplicate timestamps from a TimeSeries based on a Combiner function. |

### TimeSeries Action Functions

TimeSeries actions will reduce the TimeSeries to a value

| SQL Function | Input(s) | Output | Description |
|--------------|-------|--------|-------------|
| TS_DESCRIBE(_time_series_) | DoubleTimeSeries | set of columns with all statistics for TimeSeries | describe a whole TimeSeries. This will return Timing statistics, value statistics, (optionally numeric statistics if it is a DoubleTimeSeries) |
| TS_EXPLODE(_time_series_) | DoubleTimeSeries | (Long, Double) | flatten the entire DoubleTimeSeries, creating a row for each observations with timestamp and value in separate columns |
| TS_DA_EXPLODE(_time_series_) | DoubleArrayTimeSeries | (Long, DoubleArray) | flatten the entire DoubleArrayTimeSeries, creating a row for each observations with timestamp and value in separate columns |

## Operations allowable on double TimeSeries 

| SQL Function | Input(s) | Output | Description |
|--------------|-------|--------|-------------|
| TS_AWGN(_time_series_, _mean_, _sd_) | DoubleTimeSeries, Double, Double | DoubleTimeSeries | add white gaussian noise to TimeSeries |
| TS_MWGN(_time_series_, _sd_) | DoubleTimeSeries, Double | add mean gaussian noise to TimeSeries |
| TS_ZSCORE(_time_series_, _mean_, _sd_) | DoubleTimeSeries, Double, Double | DoubleTimeSeries | z-normalize the TimeSeries |
| TS_PEAK(_time_series_) | DoubleTimeSeries | DoubleTimeSeries | get the peaks of the TimeSeries |
| TS_TROUGH(_time_series_) | DoubleTimeSeries | DoubleTimeSeries | get the troughs of the TimeSeries |
| TS_DIFF(_time_series_) | DoubleTimeSeries | DoubleTimeSeries | get the diff of the TimeSeries |
| TS_CORRELATION(_left_time_series_, _right_time_series_) | DoubleTimeSeries, DoubleTimeSeries | Double | get the correlation between 2 TimeSeries |
| TS_MANHATTAN_DISTANCE(_left_time_series_, _right_time_series_) | DoubleTimeSeries, DoubleTimeSeries | Double | get the manhattan distance between 2 TimeSeries |
| TS_SBD(_left_time_series_, _right_time_series_) | DoubleTimeSeries, DoubleTimeSeries | Double | get the shape-based distance between 2 TimeSeries |
| TS_DTW(_left_time_series_, _right_time_series_) | DoubleTimeSeries, DoubleTimeSeries | Double | get the dtw distance between 2 TimeSeries |
| TS_DL(_left_time_series_, _right_time_series_) | DoubleTimeSeries, DoubleTimeSeries | Double | get the dl distance between 2 TimeSeries |
| TS_AVG(_time_series_) | DoubleTimeSeries | Double | get the average over the TimeSeries |
| TS_MIN(_time_series_) | DoubleTimeSeries | Double | get the min over the TimeSeries |
| TS_MAX(_time_series_) | DoubleTimeSeries | Double | get the max over the TimeSeries |
| TS_SUM(_time_series_) | DoubleTimeSeries | Double | get the sum over the TimeSeries |
| TS_SD(_time_series_) | DoubleTimeSeries | Double | get the sd over the TimeSeries |
| TS_KURTOSIS(_time_series_) | DoubleTimeSeries | Double | get the kurtosis over the TimeSeries |
| TS_SKEWNESS(_time_series_) | DoubleTimeSeries | Double | get the skewness over the TimeSeries |
| TS_FORECAST(_time_series_, _forecasting_model_, _how_far_) | DoubleTimeSeries, ForecastingModel, Long | DoubleTimeSeries | forecast out given *how_far* and return the TimeSeries with the newly forecasted values |  
| TS_DETECT_ANOMALIES(_time_series_, _forecasting_model_, _confidence_) | DoubleTimeSeries, ForecastingModel, Double | DoubleTimeSeries | find all anomalies in a TimeSeries using the given ForecastingModel and confidence and return the TimeSeries of anomalies |
| TS_GRANGER(_left_time_series_, _right_time_series_, _lag_) | DoubleTimeSeries, DoubleTimeSeries, Number | array | Given 2 TimeSeries, get a Granger test result in the form of an array of fStat, pValue, R2 |

## Operations allowable on double segment TimeSeries

| SQL Function | Input(s) | Output | Description |
|--------------|-------|--------|-------------|
| TS_SEG_CORRELATION(_left_time_series_, _right_time_series_) | DoubleSegmentTimeSeries, DoubleSegmentTimeSeries | DoubleTimeSeries | get the correlation over each segment between 2 TimeSeries |
| TS_SEG_MANHATTAN_DISTANCE(_left_time_series_, _right_time_series_) | DoubleSegmentTimeSeries, DoubleSegmentTimeSeries | DoubleTimeSeries | get the manhattan distance over each segment between 2 TimeSeries |
| TS_SEG_SBD(_left_time_series_, _right_time_series_) | DoubleSegmentTimeSeries, DoubleSegmentTimeSeries | DoubleTimeSeries | get the shape-based distance over each segment between 2 TimeSeries |
| TS_SEG_DTW(_left_time_series_, _right_time_series_) | DoubleSegmentTimeSeries, DoubleSegmentTimeSeries | DoubleTimeSeries | get the dtw distance over each segment between 2 TimeSeries |
| TS_SEG_DL(_left_time_series_, _right_time_series_) | DoubleSegmentTimeSeries, DoubleSegmentTimeSeries | DoubleTimeSeries | get the dl distance over each segment between 2 TimeSeries |
| TS_SEG_AVG(_time_series_) | DoubleSegmentTimeSeries | DoubleTimeSeries | get the average over each segment of the TimeSeries |
| TS_SEG_MIN(_time_series_) | DoubleSegmentTimeSeries | DoubleTimeSeries | get the min over each segment of the TimeSeries |
| TS_SEG_MAX(_time_series_) | DoubleSegmentTimeSeries | DoubleTimeSeries | get the max over each segment of the TimeSeries |
| TS_SEG_SUM(_time_series_) | DoubleSegmentTimeSeries | DoubleTimeSeries | get the sum over each segment of the TimeSeries |
| TS_SEG_SD(_time_series_) | DoubleSegmentTimeSeries | DoubleTimeSeries | get the sd over each segment of the TimeSeries |
| TS_SEG_KURTOSIS(_time_series_) | DoubleSegmentTimeSeries | DoubleTimeSeries | get the kurtosis over each segment of the TimeSeries |
| TS_SEG_SKEWNESS(_time_series_) | DoubleSegmentTimeSeries | DoubleTimeSeries | get the skewness over each segment of the TimeSeries |

## Operations allowable on any array TimeSeries

| SQL Function | Input(s) | Output | Description |
|--------------|-------|--------|-------------|
| TS_TAKE_INDEX(_time_series_, _index_) | DoubleArrayTimeSeries, Int | DoubleTimeSeries | take a single index from each vector of the TimeSeries |

 
