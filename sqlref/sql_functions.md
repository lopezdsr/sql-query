---

copyright:
  year: 2018
lastupdated: "2018-12-13"

---

# SQL functions

You can use any of the following functions in your query.


## ! 

expr - Logical not.

## %

expr1 % expr2 - Returns the remainder after <code>expr1</code>/<code>expr2</code>.

**Examples:**

<pre><code>&gt; SELECT 2 % 1.8
 0.2
&gt; SELECT MOD(2, 1.8)
 0.2
</code></pre>

## &

expr1 &amp; expr2 - Returns the result of bitwise AND of <code>expr1</code> and <code>expr2</code>.

**Examples:**

<pre><code>&gt; SELECT 3 &amp; 5
 1
</code></pre>

## *

expr1 * expr2 - Returns <code>expr1</code>*<code>expr2</code>.

**Examples:**

<pre><code>&gt; SELECT 2 * 3
 6
</code></pre>

## +

expr1 + expr2 - Returns <code>expr1</code>+<code>expr2</code>.

**Examples:**

<pre><code>&gt; SELECT 1 + 2
 3
</code></pre>

## -

expr1 - expr2 - Returns <code>expr1</code>-<code>expr2</code>.

**Examples:**

<pre><code>&gt; SELECT 2 - 1
 1
</code></pre>

## /

expr1 / expr2 - Returns <code>expr1</code>/<code>expr2</code>. It always performs floating point division.

**Examples:**

<pre><code>&gt; SELECT 3 / 2
 1.5
&gt; SELECT 2L / 2L
 1.0
</code></pre>

## &lt;

expr1 &lt; expr2 - Returns true if <code>expr1</code> is less than <code>expr2</code>.

**Arguments:**

<ul>
<li>expr1, expr2 - the two expressions must be same type or can be casted to a common type,
    and must be a type that can be ordered. For example, map type is not orderable, so it
    is not supported. For complex types such array/struct, the data types of fields must
    be orderable.</li>
</ul>

**Examples:**

<pre><code>&gt; SELECT 1 &lt; 2
 true
&gt; SELECT 1.1 &lt; '1'
 false
&gt; SELECT to_date('2009-07-30 04:17:52') &lt; to_date('2009-07-30 04:17:52')
 false
&gt; SELECT to_date('2009-07-30 04:17:52') &lt; to_date('2009-08-01 04:17:52')
 true
&gt; SELECT 1 &lt; NULL
 NULL
</code></pre>

## &lt;=

expr1 &lt;= expr2 - Returns true if <code>expr1</code> is less than or equal to <code>expr2</code>.

**Arguments:**

<ul>
<li>expr1, expr2 - the two expressions must be same type or can be casted to a common type,
    and must be a type that can be ordered. For example, map type is not orderable, so it
    is not supported. For complex types such array/struct, the data types of fields must
    be orderable.</li>
</ul>

**Examples:**

<pre><code>&gt; SELECT 2 &lt;= 2
 true
&gt; SELECT 1.0 &lt;= '1'
 true
&gt; SELECT to_date('2009-07-30 04:17:52') &lt;= to_date('2009-07-30 04:17:52')
 true
&gt; SELECT to_date('2009-07-30 04:17:52') &lt;= to_date('2009-08-01 04:17:52')
 true
&gt; SELECT 1 &lt;= NULL
 NULL
</code></pre>

## &lt;=&gt;

expr1 &lt;=&gt; expr2 - Returns same result as the EQUAL(=) operator for non-null operands,
but returns true if both are null, false if one of the them is null.

**Arguments:**

<ul>
<li>expr1, expr2 - the two expressions must be same type or can be casted to a common type,
    and must be a type that can be used in equality comparison. Map type is not supported.
    For complex types such array/struct, the data types of fields must be orderable.</li>
</ul>

**Examples:**

<pre><code>&gt; SELECT 2 &lt;=&gt; 2
 true
&gt; SELECT 1 &lt;=&gt; '1'
 true
&gt; SELECT true &lt;=&gt; NULL
 false
&gt; SELECT NULL &lt;=&gt; NULL
 true
</code></pre>

## =

expr1 = expr2 - Returns true if <code>expr1</code> equals <code>expr2</code>, or false otherwise.

**Arguments:**

<ul>
<li>expr1, expr2 - the two expressions must be same type or can be casted to a common type,
    and must be a type that can be used in equality comparison. Map type is not supported.
    For complex types such array/struct, the data types of fields must be orderable.</li>
</ul>

**Examples:**

<pre><code>&gt; SELECT 2 = 2
 true
&gt; SELECT 1 = '1'
 true
&gt; SELECT true = NULL
 NULL
&gt; SELECT NULL = NULL
 NULL
</code></pre>

## ==

expr1 == expr2 - Returns true if <code>expr1</code> equals <code>expr2</code>, or false otherwise.

**Arguments:**

<ul>
<li>expr1, expr2 - the two expressions must be same type or can be casted to a common type,
    and must be a type that can be used in equality comparison. Map type is not supported.
    For complex types such array/struct, the data types of fields must be orderable.</li>
</ul>

**Examples:**

<pre><code>&gt; SELECT 2 == 2
 true
&gt; SELECT 1 == '1'
 true
&gt; SELECT true == NULL
 NULL
&gt; SELECT NULL == NULL
 NULL
</code></pre>

## &gt; 

expr1 &gt; expr2 - Returns true if <code>expr1</code> is greater than <code>expr2</code>.

**Arguments:**

<ul>
<li>expr1, expr2 - the two expressions must be same type or can be casted to a common type,
    and must be a type that can be ordered. For example, map type is not orderable, so it
    is not supported. For complex types such array/struct, the data types of fields must
    be orderable.</li>
</ul>

**Examples:**

<pre><code>&gt; SELECT 2 &gt; 1
 true
&gt; SELECT 2 &gt; '1.1'
 true
&gt; SELECT to_date('2009-07-30 04:17:52') &gt; to_date('2009-07-30 04:17:52')
 false
&gt; SELECT to_date('2009-07-30 04:17:52') &gt; to_date('2009-08-01 04:17:52')
 false
&gt; SELECT 1 &gt; NULL
 NULL
</code></pre>

 
## &gt;=

expr1 &gt;= expr2 - Returns true if <code>expr1</code> is greater than or equal to <code>expr2</code>.

**Arguments:**

<ul>
<li>expr1, expr2 - the two expressions must be same type or can be casted to a common type,
    and must be a type that can be ordered. For example, map type is not orderable, so it
    is not supported. For complex types such array/struct, the data types of fields must
    be orderable.</li>
</ul>

**Examples:**

<pre><code>&gt; SELECT 2 &gt;= 1
 true
&gt; SELECT 2.0 &gt;= '2.1'
 false
&gt; SELECT to_date('2009-07-30 04:17:52') &gt;= to_date('2009-07-30 04:17:52')
 true
&gt; SELECT to_date('2009-07-30 04:17:52') &gt;= to_date('2009-08-01 04:17:52')
 false
&gt; SELECT 1 &gt;= NULL
 NULL
</code></pre>

 
## ^

expr1 ^ expr2 - Returns the result of bitwise exclusive OR of <code>expr1</code> and <code>expr2</code>.

**Examples:**

<pre><code>&gt; SELECT 3 ^ 5
 2
</code></pre>

 
##abs

abs(expr) - Returns the absolute value of the numeric value.

**Examples:**

<pre><code>&gt; SELECT abs(-1)
 1
</code></pre>

 
## acos

acos(expr) - Returns the inverse cosine (a.k.a. arccosine) of <code>expr</code> if -1&lt;=<code>expr</code>&lt;=1 or NaN otherwise.

**Examples:**

<pre><code>&gt; SELECT acos(1)
 0.0
&gt; SELECT acos(2)
 NaN
</code></pre>

 
## add_months

add_months(start_date, num_months) - Returns the date that is <code>num_months</code> after <code>start_date</code>.

**Examples:**

<pre><code>&gt; SELECT add_months('2016-08-31', 1)
 2016-09-30
</code></pre>

<strong>Since:</strong> 1.5.0
 
## and

expr1 and expr2 - Logical AND.
 
## approx_count_distinct

approx_count_distinct(expr[, relativeSD]) - Returns the estimated cardinality by HyperLogLog++.
<code>relativeSD</code> defines the maximum estimation error allowed.

 
## approx_percentile

approx_percentile(col, percentage [, accuracy]) - Returns the approximate percentile value of numeric
column <code>col</code> at the given percentage. The value of percentage must be between 0.0
and 1.0. The <code>accuracy</code> parameter (default: 10000) is a positive numeric literal which
controls approximation accuracy at the cost of memory. Higher value of <code>accuracy</code> yields
better accuracy, <code>1.0/accuracy</code> is the relative error of the approximation.
When <code>percentage</code> is an array, each value of the percentage array must be between 0.0 and 1.0.
In this case, returns the approximate percentile array of column <code>col</code> at the given
percentage array.

**Examples:**

<pre><code>&gt; SELECT approx_percentile(10.0, array(0.5, 0.4, 0.1), 100)
 [10.0,10.0,10.0]
&gt; SELECT approx_percentile(10.0, 0.5, 100)
 10.0
</code></pre>

 
## array

array(expr, ...) - Returns an array with the given elements.

**Examples:**
<pre><code>&gt; SELECT array(1, 2, 3)
 [1,2,3]
</code></pre>

 
## array_contains

array_contains(array, value) - Returns true if the array contains the value.

**Examples:**
<pre><code>&gt; SELECT array_contains(array(1, 2, 3), 2)
 true
</code></pre>

 
## ascii

ascii(str) - Returns the numeric value of the first character of <code>str</code>.

**Examples:**
<pre><code>&gt; SELECT ascii('222')
 50
&gt; SELECT ascii(2)
 50
</code></pre>

 
## asin

asin(expr) - Returns the inverse sine (a.k.a. arcsine) the arc sin of <code>expr</code> if -1&lt;=<code>expr</code>&lt;=1 or NaN otherwise.

**Examples:**
<pre><code>&gt; SELECT asin(0)
 0.0
&gt; SELECT asin(2)
 NaN
</code></pre>


## atan

atan(expr) - Returns the inverse tangent (a.k.a. arctangent).

**Examples:**
<pre><code>&gt; SELECT atan(0)
 0.0
</code></pre>

 
## atan2

atan2(expr1, expr2) - Returns the angle in radians between the positive x-axis of a plane and the point given by the coordinates (<code>expr1</code>, <code>expr2</code>).

**Examples:**
<pre><code>&gt; SELECT atan2(0, 0)
 0.0
</code></pre>

 
## avg

avg(expr) - Returns the mean calculated from values of a group.

 
## base64

base64(bin) - Converts the argument from a binary <code>bin</code> to a base 64 string.

**Examples:**
<pre><code>&gt; SELECT base64('Spark SQL')
 U3BhcmsgU1FM
</code></pre>

 
## bigint

bigint(expr) - Casts the value <code>expr</code> to the target data type <code>bigint</code>.

 
## bin

bin(expr) - Returns the string representation of the long value <code>expr</code> represented in binary.

**Examples:**
<pre><code>&gt; SELECT bin(13)
 1101
&gt; SELECT bin(-13)
 1111111111111111111111111111111111111111111111111111111111110011
&gt; SELECT bin(13.3)
 1101
</code></pre>

 
## binary

binary(expr) - Casts the value <code>expr</code> to the target data type <code>binary</code>.
 
## bit_length

bit_length(expr) - Returns the bit length of string data or number of bits of binary data.

**Examples:**
<pre><code>&gt; SELECT bit_length('Spark SQL')
 72
</code></pre>

 
## boolean

boolean(expr) - Casts the value <code>expr</code> to the target data type <code>boolean</code>.
 
## bround

bround(expr, d) - Returns <code>expr</code> rounded to <code>d</code> decimal places using HALF_EVEN rounding mode.

**Examples:**
<pre><code>&gt; SELECT bround(2.5, 0)
 2.0
</code></pre>

 
## cast

cast(expr AS type) - Casts the value <code>expr</code> to the target data type <code>type</code>.

**Examples:**
<pre><code>&gt; SELECT cast('10' as int)
 10
</code></pre>

 
## cbrt

cbrt(expr) - Returns the cube root of <code>expr</code>.

**Examples:**
<pre><code>&gt; SELECT cbrt(27.0)
 3.0
</code></pre>

 
## ceil

ceil(expr) - Returns the smallest integer not smaller than <code>expr</code>.

**Examples:**
<pre><code>&gt; SELECT ceil(-0.1)
 0
&gt; SELECT ceil(5)
 5
</code></pre>

 
## ceiling

ceiling(expr) - Returns the smallest integer not smaller than <code>expr</code>.

**Examples:**
<pre><code>&gt; SELECT ceiling(-0.1)
 0
&gt; SELECT ceiling(5)
 5
</code></pre>

 
## char

char(expr) - Returns the ASCII character having the binary equivalent to <code>expr</code>. If n is larger than 256 the result is equivalent to chr(n % 256)

**Examples:**
<pre><code>&gt; SELECT char(65)
 A
</code></pre>

 
## char_length

char_length(expr) - Returns the character length of string data or number of bytes of binary data. The length of string data includes the trailing spaces. The length of binary data includes binary zeros.

**Examples:**
<pre><code>&gt; SELECT char_length('Spark SQL ')
 10
&gt; SELECT CHAR_LENGTH('Spark SQL ')
 10
&gt; SELECT CHARACTER_LENGTH('Spark SQL ')
 10
</code></pre>

 
## character_length

character_length(expr) - Returns the character length of string data or number of bytes of binary data. The length of string data includes the trailing spaces. The length of binary data includes binary zeros.

**Examples:**
<pre><code>&gt; SELECT character_length('Spark SQL ')
 10
&gt; SELECT CHAR_LENGTH('Spark SQL ')
 10
&gt; SELECT CHARACTER_LENGTH('Spark SQL ')
 10
</code></pre>

 
## chr

chr(expr) - Returns the ASCII character having the binary equivalent to <code>expr</code>. If n is larger than 256 the result is equivalent to chr(n % 256)

**Examples:**
<pre><code>&gt; SELECT chr(65)
 A
</code></pre>


## coalesce

coalesce(expr1, expr2, ...) - Returns the first non-null argument if exists. Otherwise, null.

**Examples:**

<pre><code>&gt; SELECT coalesce(NULL, 1, NULL)
 1
</code></pre>

 
## collect_list

collect_list(expr) - Collects and returns a list of non-unique elements.

 
##collect_set 

collect_set(expr) - Collects and returns a set of unique elements.

 
## concat

concat(str1, str2, ..., strN) - Returns the concatenation of str1, str2, ..., strN.

**Examples:**
<pre><code>&gt; SELECT concat('Spark', 'SQL')
 SparkSQL
</code></pre>

 
##concat_ws

concat_ws(sep, [str | array(str)]+) - Returns the concatenation of the strings separated by <code>sep</code>.

**Examples:**
<pre><code>&gt; SELECT concat_ws(' ', 'Spark', 'SQL')
  Spark SQL
</code></pre>

 
## conv

conv(num, from_base, to_base) - Convert <code>num</code> from <code>from_base</code> to <code>to_base</code>.

**Examples:**

<pre><code>&gt; SELECT conv('100', 2, 10)
 4
&gt; SELECT conv(-10, 16, -10)
 -16
</code></pre>

 
## corr

corr(expr1, expr2) - Returns Pearson coefficient of correlation between a set of number pairs.

 
## cos

cos(expr) - Returns the cosine of <code>expr</code>.

**Examples:**

<pre><code>&gt; SELECT cos(0)
 1.0
</code></pre>

 
## cosh

cosh(expr) - Returns the hyperbolic cosine of <code>expr</code>.

**Examples:**

<pre><code>&gt; SELECT cosh(0)
 1.0
</code></pre>

 
## cot

cot(expr) - Returns the cotangent of <code>expr</code>.

**Examples:**

<pre><code>&gt; SELECT cot(1)
 0.6420926159343306
</code></pre>

 
## count

count(*) - Returns the total number of retrieved rows, including rows containing null.

count(expr) - Returns the number of rows for which the supplied expression is non-null.

count(DISTINCT expr[, expr...]) - Returns the number of rows for which the supplied expression(s) are unique and non-null.

 
## count_min_sketch

count_min_sketch(col, eps, confidence, seed) - Returns a count-min sketch of a column with the given esp,
confidence and seed. The result is an array of bytes, which can be deserialized to a
<code>CountMinSketch</code> before usage. Count-min sketch is a probabilistic data structure used for
cardinality estimation using sub-linear space.

 
## covar_pop

covar_pop(expr1, expr2) - Returns the population covariance of a set of number pairs.

 
## covar_samp

covar_samp(expr1, expr2) - Returns the sample covariance of a set of number pairs.


## crc32

crc32(expr) - Returns a cyclic redundancy check value of the <code>expr</code> as a bigint.

**Examples:**

<pre><code>&gt; SELECT crc32('Spark')
 1557323817
</code></pre>

 
## cube
 
## cume_dist

cume_dist() - Computes the position of a value relative to all values in the partition.

 
## current_database

current_database() - Returns the current database.

**Examples:**

<pre><code>&gt; SELECT current_database()
 default
</code></pre>

 
## current_date

current_date() - Returns the current date at the start of query evaluation.

<strong>Since:</strong> 1.5.0

 
## current_timestamp

current_timestamp() - Returns the current timestamp at the start of query evaluation.

<strong>Since:</strong> 1.5.0

 
## date

date(expr) - Casts the value <code>expr</code> to the target data type <code>date</code>.

 
## date_add

date_add(start_date, num_days) - Returns the date that is <code>num_days</code> after <code>start_date</code>.

**Examples:**

<pre><code>&gt; SELECT date_add('2016-07-30', 1)
 2016-07-31
</code></pre>

<strong>Since:</strong> 1.5.0

 
## date_format

date_format(timestamp, fmt) - Converts <code>timestamp</code> to a value of string in the format specified by the date format <code>fmt</code>.

**Examples:**

<pre><code>&gt; SELECT date_format('2016-04-08', 'y')
 2016
</code></pre>

<strong>Since:</strong> 1.5.0

 
## date_sub

date_sub(start_date, num_days) - Returns the date that is <code>num_days</code> before <code>start_date</code>.

**Examples:**

<pre><code>&gt; SELECT date_sub('2016-07-30', 1)
 2016-07-29
</code></pre>

<strong>Since:</strong> 1.5.0

 
## date_trunc

date_trunc(fmt, ts) - Returns timestamp <code>ts</code> truncated to the unit specified by the format model <code>fmt</code>.
<code>fmt</code> should be one of ["YEAR", "YYYY", "YY", "MON", "MONTH", "MM", "DAY", "DD", "HOUR", "MINUTE", "SECOND", "WEEK", "QUARTER"]

**Examples:**

<pre><code>&gt; SELECT date_trunc('2015-03-05T09:32:05.359', 'YEAR')
 2015-01-01T00:00:00
&gt; SELECT date_trunc('2015-03-05T09:32:05.359', 'MM')
 2015-03-01T00:00:00
&gt; SELECT date_trunc('2015-03-05T09:32:05.359', 'DD')
 2015-03-05T00:00:00
&gt; SELECT date_trunc('2015-03-05T09:32:05.359', 'HOUR')
 2015-03-05T09:00:00
</code></pre>

<strong>Since:</strong> 2.3.0

 
## datediff

datediff(endDate, startDate) - Returns the number of days from <code>startDate</code> to <code>endDate</code>.

**Examples:**

<pre><code>&gt; SELECT datediff('2009-07-31', '2009-07-30')
 1

&gt; SELECT datediff('2009-07-30', '2009-07-31')
 -1
</code></pre>

<strong>Since:</strong> 1.5.0

 
## day

day(date) - Returns the day of month of the date/timestamp.

**Examples:**

<pre><code>&gt; SELECT day('2009-07-30')
 30
</code></pre>

<strong>Since:</strong> 1.5.0

 
## dayofmonth

dayofmonth(date) - Returns the day of month of the date/timestamp.

**Examples:**

<pre><code>&gt; SELECT dayofmonth('2009-07-30')
 30
</code></pre>

<strong>Since:</strong> 1.5.0

 
## dayofweek

dayofweek(date) - Returns the day of the week for date/timestamp (1 = Sunday, 2 = Monday, ..., 7 = Saturday).

**Examples:**

<pre><code>&gt; SELECT dayofweek('2009-07-30')
 5
</code></pre>

<strong>Since:</strong> 2.3.0

 
## dayofyear

dayofyear(date) - Returns the day of year of the date/timestamp.

**Examples:**

<pre><code>&gt; SELECT dayofyear('2016-04-09')
 100
</code></pre>

<strong>Since:</strong> 1.5.0

 
## decimal

decimal(expr) - Casts the value <code>expr</code> to the target data type <code>decimal</code>.

 
## decode

decode(bin, charset) - Decodes the first argument using the second argument character set.

**Examples:**

<pre><code>&gt; SELECT decode(encode('abc', 'utf-8'), 'utf-8')
 abc
</code></pre>

 
## degrees

degrees(expr) - Converts radians to degrees.

**Examples:**

<pre><code>&gt; SELECT degrees(3.141592653589793)
 180.0
</code></pre>

 
## dense_rank

dense_rank() - Computes the rank of a value in a group of values. The result is one plus the
previously assigned rank value. Unlike the function rank, dense_rank will not produce gaps
in the ranking sequence.

 
## double

double(expr) - Casts the value <code>expr</code> to the target data type <code>double</code>.

 
## e

e() - Returns Euler's number, e.

**Examples:**

<pre><code>&gt; SELECT e()
 2.718281828459045
</code></pre>

 
## elt

elt(n, input1, input2, ...) - Returns the <code>n</code>-th input, e.g., returns <code>input2</code> when <code>n</code> is 2.

**Examples:**

<pre><code>&gt; SELECT elt(1, 'scala', 'java')
 scala
</code></pre>

 
## encode

encode(str, charset) - Encodes the first argument using the second argument character set.

**Examples:**

<pre><code>&gt; SELECT encode('abc', 'utf-8')
 abc
</code></pre>

 
## exp

exp(expr) - Returns e to the power of <code>expr</code>.

**Examples:**

<pre><code>&gt; SELECT exp(0)
 1.0
</code></pre>

 
## explode

explode(expr) - Separates the elements of array <code>expr</code> into multiple rows, or the elements of map <code>expr</code> into multiple rows and columns.

**Examples:**

<pre><code>&gt; SELECT explode(array(10, 20))
 10
 20
</code></pre>

 
## explode_outer

explode_outer(expr) - Separates the elements of array <code>expr</code> into multiple rows, or the elements of map <code>expr</code> into multiple rows and columns.

**Examples:**

<pre><code>&gt; SELECT explode_outer(array(10, 20))
 10
 20
</code></pre>

 
## expm1

expm1(expr) - Returns exp(<code>expr</code>) - 1.

**Examples:**

<pre><code>&gt; SELECT expm1(0)
 0.0
</code></pre>

 
## factorial

factorial(expr) - Returns the factorial of <code>expr</code>. <code>expr</code> is [0..20]. Otherwise, null.

**Examples:**

<pre><code>&gt; SELECT factorial(5)
 120
</code></pre>

 
## find_in_set

find_in_set(str, str_array) - Returns the index (1-based) of the given string (<code>str</code>) in the comma-delimited list (<code>str_array</code>).
Returns 0, if the string was not found or if the given string (<code>str</code>) contains a comma.

**Examples:**

<pre><code>&gt; SELECT find_in_set('ab','abc,b,ab,c,def')
 3
</code></pre>

 
## first

first(expr[, isIgnoreNull]) - Returns the first value of <code>expr</code> for a group of rows.
If <code>isIgnoreNull</code> is true, returns only non-null values.

 
## first_value

first_value(expr[, isIgnoreNull]) - Returns the first value of <code>expr</code> for a group of rows.
If <code>isIgnoreNull</code> is true, returns only non-null values.

 
## float

float(expr) - Casts the value <code>expr</code> to the target data type <code>float</code>.

 
## floor

floor(expr) - Returns the largest integer not greater than <code>expr</code>.

**Examples:**

<pre><code>&gt; SELECT floor(-0.1)
 -1
&gt; SELECT floor(5)
 5
</code></pre>

 
## format_number

format_number(expr1, expr2) - Formats the number <code>expr1</code> like '#,###,###.##', rounded to <code>expr2</code>
decimal places. If <code>expr2</code> is 0, the result has no decimal point or fractional part.
This is supposed to function like MySQL's FORMAT.

**Examples:**

<pre><code>&gt; SELECT format_number(12332.123456, 4)
 12,332.1235
</code></pre>

 
## format_string

format_string(strfmt, obj, ...) - Returns a formatted string from printf-style format strings.

**Examples:**

<pre><code>&gt; SELECT format_string(&quot;Hello World %d %s&quot;, 100, &quot;days&quot;)
 Hello World 100 days
</code></pre>

 
## from_json

from_json(jsonStr, schema[, options]) - Returns a struct value with the given <code>jsonStr</code> and <code>schema</code>.

**Examples:**

<pre><code>&gt; SELECT from_json('{&quot;a&quot;:1, &quot;b&quot;:0.8}', 'a INT, b DOUBLE')
 {&quot;a&quot;:1, &quot;b&quot;:0.8}
&gt; SELECT from_json('{&quot;time&quot;:&quot;26/08/2015&quot;}', 'time Timestamp', map('timestampFormat', 'dd/MM/yyyy'))
 {&quot;time&quot;:&quot;2015-08-26 00:00:00.0&quot;}
</code></pre>

<strong>Since:</strong> 2.2.0

 
## from_unixtime

from_unixtime(unix_time, format) - Returns <code>unix_time</code> in the specified <code>format</code>.

**Examples:**

<pre><code>&gt; SELECT from_unixtime(0, 'yyyy-MM-dd HH:mm:ss')
 1970-01-01 00:00:00
</code></pre>

<strong>Since:</strong> 1.5.0

 
## from_utc_timestamp

from_utc_timestamp(timestamp, timezone) - Given a timestamp like '2017-07-14 02:40:00.0', interprets it as a time in UTC, and renders that time as a timestamp in the given time zone. For example, 'GMT+1' would yield '2017-07-14 03:40:00.0'.

**Examples:**

<pre><code>&gt; SELECT from_utc_timestamp('2016-08-31', 'Asia/Seoul')
 2016-08-31 09:00:00
</code></pre>

<strong>Since:</strong> 1.5.0

 
## get_json_object

get_json_object(json_txt, path) - Extracts a json object from <code>path</code>.

**Examples:**

<pre><code>&gt; SELECT get_json_object('{&quot;a&quot;:&quot;b&quot;}', '$.a')
 b
</code></pre>

 
## greatest

greatest(expr, ...) - Returns the greatest value of all parameters, skipping null values.

**Examples:**

<pre><code>&gt; SELECT greatest(10, 9, 2, 4, 3)
 10
</code></pre>

 
## grouping

 
## grouping_id

 
## hash

hash(expr1, expr2, ...) - Returns a hash value of the arguments.

**Examples:**

<pre><code>&gt; SELECT hash('Spark', array(123), 2)
 -1321691492
</code></pre>

 
## hex

hex(expr) - Converts <code>expr</code> to hexadecimal.

**Examples:**

<pre><code>&gt; SELECT hex(17)
 11
&gt; SELECT hex('Spark SQL')
 537061726B2053514C
</code></pre>

 
## hour

hour(timestamp) - Returns the hour component of the string/timestamp.

**Examples:**

<pre><code>&gt; SELECT hour('2009-07-30 12:58:59')
 12
</code></pre>

<strong>Since:</strong> 1.5.0

 
## hypot

hypot(expr1, expr2) - Returns sqrt(<code>expr1</code><strong>2 + <code>expr2</code></strong>2).

**Examples:**

<pre><code>&gt; SELECT hypot(3, 4)
 5.0
</code></pre>

 
## if

if(expr1, expr2, expr3) - If <code>expr1</code> evaluates to true, then returns <code>expr2</code>; otherwise returns <code>expr3</code>.

**Examples:**

<pre><code>&gt; SELECT if(1 &lt; 2, 'a', 'b')
 a
</code></pre>

 
## ifnull

ifnull(expr1, expr2) - Returns <code>expr2</code> if <code>expr1</code> is null, or <code>expr1</code> otherwise.

**Examples:**

<pre><code>&gt; SELECT ifnull(NULL, array('2'))
 [&quot;2&quot;]
</code></pre>

 
## in

expr1 in(expr2, expr3, ...) - Returns true if <code>expr</code> equals to any valN.

**Arguments:**

<ul>
<li>expr1, expr2, expr3, ... - the arguments must be same type.</li>
</ul>

**Examples:**

<pre><code>&gt; SELECT 1 in(1, 2, 3)
 true
&gt; SELECT 1 in(2, 3, 4)
 false
&gt; SELECT named_struct('a', 1, 'b', 2) in(named_struct('a', 1, 'b', 1), named_struct('a', 1, 'b', 3))
 false
&gt; SELECT named_struct('a', 1, 'b', 2) in(named_struct('a', 1, 'b', 2), named_struct('a', 1, 'b', 3))
 true
</code></pre>

 
## initcap

initcap(str) - Returns <code>str</code> with the first letter of each word in uppercase.
All other letters are in lowercase. Words are delimited by white space.

**Examples:**

<pre><code>&gt; SELECT initcap('sPark sql')
 Spark Sql
</code></pre>

 
## inline

inline(expr) - Explodes an array of structs into a table.

**Examples:**

<pre><code>&gt; SELECT inline(array(struct(1, 'a'), struct(2, 'b')))
 1  a
 2  b
</code></pre>

 
## inline_outer

inline_outer(expr) - Explodes an array of structs into a table.

**Examples:**

<pre><code>&gt; SELECT inline_outer(array(struct(1, 'a'), struct(2, 'b')))
 1  a
 2  b
</code></pre>


## input_file_name

input_file_name() - Returns the name of the file being read, or empty string if not available.

 
## instr

instr(str, substr) - Returns the (1-based) index of the first occurrence of <code>substr</code> in <code>str</code>.

**Examples:**

<pre><code>&gt; SELECT instr('SparkSQL', 'SQL')
 6
</code></pre>

 
## int

int(expr) - Casts the value <code>expr</code> to the target data type <code>int</code>.

 
## isnan

isnan(expr) - Returns true if <code>expr</code> is NaN, or false otherwise.

**Examples:**

<pre><code>&gt; SELECT isnan(cast('NaN' as double))
 true
</code></pre>

 
## isnotnull

isnotnull(expr) - Returns true if <code>expr</code> is not null, or false otherwise.

**Examples:**

<pre><code>&gt; SELECT isnotnull(1)
 true
</code></pre>

 
## isnull

isnull(expr) - Returns true if <code>expr</code> is null, or false otherwise.

**Examples:**

<pre><code>&gt; SELECT isnull(1)
 false
</code></pre>

 
## json_tuple

json_tuple(jsonStr, p1, p2, ..., pn) - Returns a tuple like the function get_json_object, but it takes multiple names. All the input parameters and output column types are string.

**Examples:**

<pre><code>&gt; SELECT json_tuple('{&quot;a&quot;:1, &quot;b&quot;:2}', 'a', 'b')
 1  2
</code></pre>

 
## kurtosis

kurtosis(expr) - Returns the kurtosis value calculated from values of a group.

 
## lag

lag(input[, offset[, default]]) - Returns the value of <code>input</code> at the <code>offset</code>th row
before the current row in the window. The default value of <code>offset</code> is 1 and the default
value of <code>default</code> is null. If the value of <code>input</code> at the <code>offset</code>th row is null,
null is returned. If there is no such offset row (e.g., when the offset is 1, the first
row of the window does not have any previous row), <code>default</code> is returned.

 
## last

last(expr[, isIgnoreNull]) - Returns the last value of <code>expr</code> for a group of rows.
If <code>isIgnoreNull</code> is true, returns only non-null values.

 
## last_day

last_day(date) - Returns the last day of the month which the date belongs to.

**Examples:**

<pre><code>&gt; SELECT last_day('2009-01-12')
 2009-01-31
</code></pre>

<strong>Since:</strong> 1.5.0

 
## last_value

last_value(expr[, isIgnoreNull]) - Returns the last value of <code>expr</code> for a group of rows.
If <code>isIgnoreNull</code> is true, returns only non-null values.

 
## lcase

lcase(str) - Returns <code>str</code> with all characters changed to lowercase.

**Examples:**

<pre><code>&gt; SELECT lcase('SparkSql')
 sparksql
</code></pre>

 
## lead

lead(input[, offset[, default]]) - Returns the value of <code>input</code> at the <code>offset</code>th row
after the current row in the window. The default value of <code>offset</code> is 1 and the default
value of <code>default</code> is null. If the value of <code>input</code> at the <code>offset</code>th row is null,
null is returned. If there is no such an offset row (e.g., when the offset is 1, the last
row of the window does not have any subsequent row), <code>default</code> is returned.

 
## least

least(expr, ...) - Returns the least value of all parameters, skipping null values.

**Examples:**

<pre><code>&gt; SELECT least(10, 9, 2, 4, 3)
 2
</code></pre>

 
## left

left(str, len) - Returns the leftmost <code>len</code>(<code>len</code> can be string type) characters from the string <code>str</code>,if <code>len</code> is less or equal than 0 the result is an empty string.

**Examples:**

<pre><code>&gt; SELECT left('Spark SQL', 3)
 Spa
</code></pre>

 
## length

length(expr) - Returns the character length of string data or number of bytes of binary data. The length of string data includes the trailing spaces. The length of binary data includes binary zeros.

**Examples:**

<pre><code>&gt; SELECT length('Spark SQL ')
 10
&gt; SELECT CHAR_LENGTH('Spark SQL ')
 10
&gt; SELECT CHARACTER_LENGTH('Spark SQL ')
 10
</code></pre>

 
## levenshtein

levenshtein(str1, str2) - Returns the Levenshtein distance between the two given strings.

**Examples:**

<pre><code>&gt; SELECT levenshtein('kitten', 'sitting')
 3
</code></pre>

 
## like

str like pattern - Returns true if str matches pattern, null if any arguments are null, false otherwise.

**Arguments:**

<ul>
<li>str - a string expression</li>
<li>

pattern - a string expression. The pattern is a string which is matched literally, with
    exception to the following special symbols:

_ matches any one character in the input (similar to . in posix regular expressions)

% matches zero or more characters in the input (similar to .* in posix regular
expressions)

The escape character is '\'. If an escape character precedes a special symbol or another
escape character, the following character is matched literally. It is invalid to escape
any other character.

Since Spark 2.0, string literals are unescaped in our SQL parser. For example, in order
to match "\abc", the pattern should be "\abc".

When SQL config 'spark.sql.parser.escapedStringLiterals' is enabled, it fallbacks
to Spark 1.6 behavior regarding string literal parsing. For example, if the config is
enabled, the pattern to match "\abc" should be "\abc".

</li>
</ul>
**Examples:**

<pre><code>&gt; SELECT '%SystemDrive%\Users\John' like '\%SystemDrive\%\\Users%'
true
</code></pre>


<strong>Note:</strong>

Use RLIKE to match with standard regular expressions.

 
## ln

ln(expr) - Returns the natural logarithm (base e) of <code>expr</code>.

**Examples:**

<pre><code>&gt; SELECT ln(1)
 0.0
</code></pre>

 
## locate

locate(substr, str[, pos]) - Returns the position of the first occurrence of <code>substr</code> in <code>str</code> after position <code>pos</code>.
The given <code>pos</code> and return value are 1-based.

**Examples:**

<pre><code>&gt; SELECT locate('bar', 'foobarbar')
 4
&gt; SELECT locate('bar', 'foobarbar', 5)
 7
&gt; SELECT POSITION('bar' IN 'foobarbar')
 4
</code></pre>

 
## log

log(base, expr) - Returns the logarithm of <code>expr</code> with <code>base</code>.

**Examples:**

<pre><code>&gt; SELECT log(10, 100)
 2.0
</code></pre>

 
## log10

log10(expr) - Returns the logarithm of <code>expr</code> with base 10.

**Examples:**

<pre><code>&gt; SELECT log10(10)
 1.0
</code></pre>

 
## log1p

log1p(expr) - Returns log(1 + <code>expr</code>).

**Examples:**

<pre><code>&gt; SELECT log1p(0)
 0.0
</code></pre>

 
## log2

log2(expr) - Returns the logarithm of <code>expr</code> with base 2.

**Examples:**

<pre><code>&gt; SELECT log2(2)
 1.0
</code></pre>

 
## lower

lower(str) - Returns <code>str</code> with all characters changed to lowercase.

**Examples:**

<pre><code>&gt; SELECT lower('SparkSql')
 sparksql
</code></pre>

 
## lpad

lpad(str, len, pad) - Returns <code>str</code>, left-padded with <code>pad</code> to a length of <code>len</code>.
If <code>str</code> is longer than <code>len</code>, the return value is shortened to <code>len</code> characters.

**Examples:**

<pre><code>&gt; SELECT lpad('hi', 5, '??')
 ???hi
&gt; SELECT lpad('hi', 1, '??')
 h
</code></pre>

 
## ltrim

ltrim(str) - Removes the leading space characters from <code>str</code>.

ltrim(trimStr, str) - Removes the leading string contains the characters from the trim string

**Arguments:**

<ul>
<li>str - a string expression</li>
<li>trimStr - the trim string characters to trim, the default value is a single space</li>
</ul>
**Examples:**
<pre><code>&gt; SELECT ltrim('    SparkSQL   ')
 SparkSQL
&gt; SELECT ltrim('Sp', 'SSparkSQLS')
 arkSQLS
</code></pre>

 
## map

map(key0, value0, key1, value1, ...) - Creates a map with the given key/value pairs.

**Examples:**

<pre><code>&gt; SELECT map(1.0, '2', 3.0, '4')
 {1.0:&quot;2&quot;,3.0:&quot;4&quot;}
</code></pre>

 
## map_keys

map_keys(map) - Returns an unordered array containing the keys of the map.

**Examples:**

<pre><code>&gt; SELECT map_keys(map(1, 'a', 2, 'b'))
 [1,2]
</code></pre>

 
## map_values

map_values(map) - Returns an unordered array containing the values of the map.

**Examples:**

<pre><code>&gt; SELECT map_values(map(1, 'a', 2, 'b'))
 [&quot;a&quot;,&quot;b&quot;]
</code></pre>

 
## max

max(expr) - Returns the maximum value of <code>expr</code>.

 
## md5

md5(expr) - Returns an MD5 128-bit checksum as a hex string of <code>expr</code>.

**Examples:**

<pre><code>&gt; SELECT md5('Spark')
 8cde774d6f7333752ed72cacddb05126
</code></pre>

 
## mean

mean(expr) - Returns the mean calculated from values of a group.

 
## min

min(expr) - Returns the minimum value of <code>expr</code>.

 
## minute

minute(timestamp) - Returns the minute component of the string/timestamp.

**Examples:**

<pre><code>&gt; SELECT minute('2009-07-30 12:58:59')
 58
</code></pre>

<strong>Since:</strong> 1.5.0

 
## mod

expr1 mod expr2 - Returns the remainder after <code>expr1</code>/<code>expr2</code>.

**Examples:**

<pre><code>&gt; SELECT 2 mod 1.8;
 0.2
&gt; SELECT MOD(2, 1.8)
 0.2
</code></pre>

 
## monotonically_increasing_id

monotonically_increasing_id() - Returns monotonically increasing 64-bit integers. The generated ID is guaranteed
to be monotonically increasing and unique, but not consecutive. The current implementation
puts the partition ID in the upper 31 bits, and the lower 33 bits represent the record number
within each partition. The assumption is that the data frame has less than 1 billion
partitions, and each partition has less than 8 billion records.

 
## month

month(date) - Returns the month component of the date/timestamp.

**Examples:**

<pre><code>&gt; SELECT month('2016-07-30')
 7
</code></pre>

<strong>Since:</strong> 1.5.0

 
## months_between

months_between(timestamp1, timestamp2) - Returns number of months between <code>timestamp1</code> and <code>timestamp2</code>.

**Examples:**

<pre><code>&gt; SELECT months_between('1997-02-28 10:30:00', '1996-10-30')
 3.94959677
</code></pre>

<strong>Since:</strong> 1.5.0

 
## named_struct

named_struct(name1, val1, name2, val2, ...) - Creates a struct with the given field names and values.

**Examples:**

<pre><code>&gt; SELECT named_struct(&quot;a&quot;, 1, &quot;b&quot;, 2, &quot;c&quot;, 3)
 {&quot;a&quot;:1,&quot;b&quot;:2,&quot;c&quot;:3}
</code></pre>

 
## nanvl

nanvl(expr1, expr2) - Returns <code>expr1</code> if it's not NaN, or <code>expr2</code> otherwise.

**Examples:**

<pre><code>&gt; SELECT nanvl(cast('NaN' as double), 123)
 123.0
</code></pre>

 
## negative

negative(expr) - Returns the negated value of <code>expr</code>.

**Examples:**

<pre><code>&gt; SELECT negative(1)
 -1
</code></pre>

 
## next_day

next_day(start_date, day_of_week) - Returns the first date which is later than <code>start_date</code> and named as indicated.

**Examples:**

<pre><code>&gt; SELECT next_day('2015-01-14', 'TU')
 2015-01-20
</code></pre>

<strong>Since:</strong> 1.5.0

 
## not

not expr - Logical not.

 
## now

now() - Returns the current timestamp at the start of query evaluation.

<strong>Since:</strong> 1.5.0

 
## ntile

ntile(n) - Divides the rows for each window partition into <code>n</code> buckets ranging
from 1 to at most <code>n</code>.

 
## nullif

nullif(expr1, expr2) - Returns null if <code>expr1</code> equals to <code>expr2</code>, or <code>expr1</code> otherwise.

**Examples:**

<pre><code>&gt; SELECT nullif(2, 2)
 NULL
</code></pre>

 
## nvl

nvl(expr1, expr2) - Returns <code>expr2</code> if <code>expr1</code> is null, or <code>expr1</code> otherwise.

**Examples:**

<pre><code>&gt; SELECT nvl(NULL, array('2'))
 [&quot;2&quot;]
</code></pre>

 
## nvl2

nvl2(expr1, expr2, expr3) - Returns <code>expr2</code> if <code>expr1</code> is not null, or <code>expr3</code> otherwise.

**Examples:**

<pre><code>&gt; SELECT nvl2(NULL, 2, 1)
 1
</code></pre>

 
## octet_length

octet_length(expr) - Returns the byte length of string data or number of bytes of binary data.

**Examples:**

<pre><code>&gt; SELECT octet_length('Spark SQL')
 9
</code></pre>

 
## or

expr1 or expr2 - Logical OR.

 
## parse_url

parse_url(url, partToExtract[, key]) - Extracts a part from a URL.

**Examples:**

<pre><code>&gt; SELECT parse_url('http://spark.apache.org/path?query=1', 'HOST')
 spark.apache.org
&gt; SELECT parse_url('http://spark.apache.org/path?query=1', 'QUERY')
 query=1
&gt; SELECT parse_url('http://spark.apache.org/path?query=1', 'QUERY', 'query')
 1
</code></pre>

 
## percent_rank

percent_rank() - Computes the percentage ranking of a value in a group of values.

 
## percentile

percentile(col, percentage [, frequency]) - Returns the exact percentile value of numeric column
<code>col</code> at the given percentage. The value of percentage must be between 0.0 and 1.0. The
value of frequency should be positive integral

percentile(col, array(percentage1 [, percentage2]...) [, frequency]) - Returns the exact
percentile value array of numeric column <code>col</code> at the given percentage(s). Each value
of the percentage array must be between 0.0 and 1.0. The value of frequency should be
positive integral

 
## percentile_approx

percentile_approx(col, percentage [, accuracy]) - Returns the approximate percentile value of numeric
column <code>col</code> at the given percentage. The value of percentage must be between 0.0
and 1.0. The <code>accuracy</code> parameter (default: 10000) is a positive numeric literal which
controls approximation accuracy at the cost of memory. Higher value of <code>accuracy</code> yields
better accuracy, <code>1.0/accuracy</code> is the relative error of the approximation.
When <code>percentage</code> is an array, each value of the percentage array must be between 0.0 and 1.0.
In this case, returns the approximate percentile array of column <code>col</code> at the given
percentage array.

**Examples:**

<pre><code>&gt; SELECT percentile_approx(10.0, array(0.5, 0.4, 0.1), 100)
 [10.0,10.0,10.0]
&gt; SELECT percentile_approx(10.0, 0.5, 100)
 10.0
</code></pre>

 
## pi

pi() - Returns pi.

**Examples:**

<pre><code>&gt; SELECT pi()
 3.141592653589793
</code></pre>

 
## pmod

pmod(expr1, expr2) - Returns the positive value of <code>expr1</code> mod <code>expr2</code>.

**Examples:**

<pre><code>&gt; SELECT pmod(10, 3)
 1
&gt; SELECT pmod(-10, 3)
 2
</code></pre>

 
## posexplode

posexplode(expr) - Separates the elements of array <code>expr</code> into multiple rows with positions, or the elements of map <code>expr</code> into multiple rows and columns with positions.

**Examples:**

<pre><code>&gt; SELECT posexplode(array(10,20))
 0  10
 1  20
</code></pre>

 
## posexplode_outer

posexplode_outer(expr) - Separates the elements of array <code>expr</code> into multiple rows with positions, or the elements of map <code>expr</code> into multiple rows and columns with positions.

**Examples:**

<pre><code>&gt; SELECT posexplode_outer(array(10,20))
 0  10
 1  20
</code></pre>

 
## position

position(substr, str[, pos]) - Returns the position of the first occurrence of <code>substr</code> in <code>str</code> after position <code>pos</code>.
The given <code>pos</code> and return value are 1-based.

**Examples:**

<pre><code>&gt; SELECT position('bar', 'foobarbar')
 4
&gt; SELECT position('bar', 'foobarbar', 5)
 7
&gt; SELECT POSITION('bar' IN 'foobarbar')
 4
</code></pre>

 
## positive

positive(expr) - Returns the value of <code>expr</code>.

 
## pow

pow(expr1, expr2) - Raises <code>expr1</code> to the power of <code>expr2</code>.

**Examples:**

<pre><code>&gt; SELECT pow(2, 3)
 8.0
</code></pre>

 
## power

power(expr1, expr2) - Raises <code>expr1</code> to the power of <code>expr2</code>.

**Examples:**

<pre><code>&gt; SELECT power(2, 3)
 8.0
</code></pre>

 
## printf

printf(strfmt, obj, ...) - Returns a formatted string from printf-style format strings.

**Examples:**

<pre><code>&gt; SELECT printf(&quot;Hello World %d %s&quot;, 100, &quot;days&quot;)
 Hello World 100 days
</code></pre>

 
## quarter

quarter(date) - Returns the quarter of the year for date, in the range 1 to 4.

**Examples:**

<pre><code>&gt; SELECT quarter('2016-08-31')
 3
</code></pre>

<strong>Since:</strong> 1.5.0

 
## radians

radians(expr) - Converts degrees to radians.

**Examples:**

<pre><code>&gt; SELECT radians(180)
 3.141592653589793
</code></pre>

 
## rand

rand([seed]) - Returns a random value with independent and identically distributed (i.i.d.) uniformly distributed values in [0, 1).

**Examples:**

<pre><code>&gt; SELECT rand()
 0.9629742951434543
&gt; SELECT rand(0)
 0.8446490682263027
&gt; SELECT rand(null)
 0.8446490682263027
</code></pre>

 
## randn

randn([seed]) - Returns a random value with independent and identically distributed (i.i.d.) values drawn from the standard normal distribution.

**Examples:**

<pre><code>&gt; SELECT randn()
 -0.3254147983080288
&gt; SELECT randn(0)
 1.1164209726833079
&gt; SELECT randn(null)
 1.1164209726833079
</code></pre>

 
## rank

rank() - Computes the rank of a value in a group of values. The result is one plus the number
of rows preceding or equal to the current row in the ordering of the partition. The values
will produce gaps in the sequence.

 
## regexp_extract

regexp_extract(str, regexp[, idx]) - Extracts a group that matches <code>regexp</code>.

**Examples:**

<pre><code>&gt; SELECT regexp_extract('100-200', '(\d+)-(\d+)', 1)
 100
</code></pre>

 
## regexp_replace

regexp_replace(str, regexp, rep) - Replaces all substrings of <code>str</code> that match <code>regexp</code> with <code>rep</code>.

**Examples:**

<pre><code>&gt; SELECT regexp_replace('100-200', '(\d+)', 'num')
 num-num
</code></pre>

 
## repeat

repeat(str, n) - Returns the string which repeats the given string value n times.

**Examples:**

<pre><code>&gt; SELECT repeat('123', 2)
 123123
</code></pre>

 
## replace

replace(str, search[, replace]) - Replaces all occurrences of <code>search</code> with <code>replace</code>.

**Arguments:**

<ul>
<li>str - a string expression</li>
<li>search - a string expression. If <code>search</code> is not found in <code>str</code>, <code>str</code> is returned unchanged.</li>
<li>replace - a string expression. If <code>replace</code> is not specified or is an empty string, nothing replaces
    the string that is removed from <code>str</code>.</li>
</ul>
**Examples:**
<pre><code>&gt; SELECT replace('ABCabc', 'abc', 'DEF')
 ABCDEF
</code></pre>

 
## reverse

reverse(str) - Returns the reversed given string.

**Examples:**

<pre><code>&gt; SELECT reverse('Spark SQL')
 LQS krapS
</code></pre>

 
## right

right(str, len) - Returns the rightmost <code>len</code>(<code>len</code> can be string type) characters from the string <code>str</code>,if <code>len</code> is less or equal than 0 the result is an empty string.

**Examples:**

<pre><code>&gt; SELECT right('Spark SQL', 3)
 SQL
</code></pre>

 
## rint

rint(expr) - Returns the double value that is closest in value to the argument and is equal to a mathematical integer.

**Examples:**

<pre><code>&gt; SELECT rint(12.3456)
 12.0
</code></pre>

 
## rlike

str rlike regexp - Returns true if <code>str</code> matches <code>regexp</code>, or false otherwise.

**Arguments:**

<ul>
<li>str - a string expression</li>
<li>

regexp - a string expression. The pattern string should be a Java regular expression.

Since Spark 2.0, string literals (including regex patterns) are unescaped in our SQL
parser. For example, to match "\abc", a regular expression for <code>regexp</code> can be
"^\abc$".

There is a SQL config 'spark.sql.parser.escapedStringLiterals' that can be used to
fallback to the Spark 1.6 behavior regarding string literal parsing. For example,
if the config is enabled, the <code>regexp</code> that can match "\abc" is "^\abc$".

</li>
</ul>
**Examples:**

<pre><code>When spark.sql.parser.escapedStringLiterals is disabled (default).
&gt; SELECT '%SystemDrive%\Users\John' rlike '%SystemDrive%\\Users.*'
true

When spark.sql.parser.escapedStringLiterals is enabled.
&gt; SELECT '%SystemDrive%\Users\John' rlike '%SystemDrive%\Users.*'
true
</code></pre>

<strong>Note:</strong>

Use LIKE to match with simple string pattern.

 
## rollup
 
## round

round(expr, d) - Returns <code>expr</code> rounded to <code>d</code> decimal places using HALF_UP rounding mode.

**Examples:**

<pre><code>&gt; SELECT round(2.5, 0)
 3.0
</code></pre>

 
## row_number

row_number() - Assigns a unique, sequential number to each row, starting with one,
according to the ordering of rows within the window partition.

 
## rpad

rpad(str, len, pad) - Returns <code>str</code>, right-padded with <code>pad</code> to a length of <code>len</code>.
If <code>str</code> is longer than <code>len</code>, the return value is shortened to <code>len</code> characters.

**Examples:**

<pre><code>&gt; SELECT rpad('hi', 5, '??')
 hi???
&gt; SELECT rpad('hi', 1, '??')
 h
</code></pre>

 
## rtrim

rtrim(str) - Removes the trailing space characters from <code>str</code>.


rtrim(trimStr, str) - Removes the trailing string which contains the characters from the trim string from the <code>str</code>

**Arguments:**

<ul>
<li>str - a string expression</li>
<li>trimStr - the trim string characters to trim, the default value is a single space</li>
</ul>

**Examples:**

<pre><code>&gt; SELECT rtrim('    SparkSQL   ')
 SparkSQL
&gt; SELECT rtrim('LQSa', 'SSparkSQLS')
 SSpark
</code></pre>

 
## second

second(timestamp) - Returns the second component of the string/timestamp.

**Examples:**

<pre><code>&gt; SELECT second('2009-07-30 12:58:59')
 59
</code></pre>

<strong>Since:</strong> 1.5.0

 
## sentences

sentences(str[, lang, country]) - Splits <code>str</code> into an array of array of words.

**Examples:**

<pre><code>&gt; SELECT sentences('Hi there! Good morning.')
 [[&quot;Hi&quot;,&quot;there&quot;],[&quot;Good&quot;,&quot;morning&quot;]]
</code></pre>

 
## sha

sha(expr) - Returns a sha1 hash value as a hex string of the <code>expr</code>.

**Examples:**

<pre><code>&gt; SELECT sha('Spark')
 85f5955f4b27a9a4c2aab6ffe5d7189fc298b92c
</code></pre>

 
## sha1

sha1(expr) - Returns a sha1 hash value as a hex string of the <code>expr</code>.

**Examples:**

<pre><code>&gt; SELECT sha1('Spark')
 85f5955f4b27a9a4c2aab6ffe5d7189fc298b92c
</code></pre>

 
## sha2

sha2(expr, bitLength) - Returns a checksum of SHA-2 family as a hex string of <code>expr</code>.
SHA-224, SHA-256, SHA-384, and SHA-512 are supported. Bit length of 0 is equivalent to 256.

**Examples:**

<pre><code>&gt; SELECT sha2('Spark', 256)
 529bc3b07127ecb7e53a4dcf1991d9152c24537d919178022b2c42657f79a26b
</code></pre>

 
## shiftleft

shiftleft(base, expr) - Bitwise left shift.

**Examples:**

<pre><code>&gt; SELECT shiftleft(2, 1)
 4
</code></pre>

 
<h3 id="shiftright">shiftright</h3>

shiftright(base, expr) - Bitwise (signed) right shift.

**Examples:**

<pre><code>&gt; SELECT shiftright(4, 1)
 2
</code></pre>

 
## shiftrightunsigned

shiftrightunsigned(base, expr) - Bitwise unsigned right shift.

**Examples:**

<pre><code>&gt; SELECT shiftrightunsigned(4, 1)
 2
</code></pre>

 
## sign

sign(expr) - Returns -1.0, 0.0 or 1.0 as <code>expr</code> is negative, 0 or positive.

**Examples:**

<pre><code>&gt; SELECT sign(40)
 1.0
</code></pre>

 
## signum

signum(expr) - Returns -1.0, 0.0 or 1.0 as <code>expr</code> is negative, 0 or positive.

**Examples:**

<pre><code>&gt; SELECT signum(40)
 1.0
</code></pre>

 
## sin

sin(expr) - Returns the sine of <code>expr</code>.

**Examples:**

<pre><code>&gt; SELECT sin(0)
 0.0
</code></pre>

 
<h3 id="sinh">sinh</h3>

sinh(expr) - Returns the hyperbolic sine of <code>expr</code>.

**Examples:**

<pre><code>&gt; SELECT sinh(0)
 0.0
</code></pre>

 
## size

size(expr) - Returns the size of an array or a map. Returns -1 if null.

**Examples:**

<pre><code>&gt; SELECT size(array('b', 'd', 'c', 'a'))
 4
</code></pre>

 
## skewness

skewness(expr) - Returns the skewness value calculated from values of a group.

 
## smallint

smallint(expr) - Casts the value <code>expr</code> to the target data type <code>smallint</code>.

 
## sort_array

sort_array(array[, ascendingOrder]) - Sorts the input array in ascending or descending order according to the natural ordering of the array elements.

**Examples:**

<pre><code>&gt; SELECT sort_array(array('b', 'd', 'c', 'a'), true)
 [&quot;a&quot;,&quot;b&quot;,&quot;c&quot;,&quot;d&quot;]
</code></pre>

 
## soundex

soundex(str) - Returns Soundex code of the string.

**Examples:**

<pre><code>&gt; SELECT soundex('Miller')
 M460
</code></pre>

 
## space

space(n) - Returns a string consisting of <code>n</code> spaces.

**Examples:**

<pre><code>&gt; SELECT concat(space(2), '1')
   1
</code></pre>

 
## spark_partition_id

spark_partition_id() - Returns the current partition id.

 
## split

split(str, regex) - Splits <code>str</code> around occurrences that match <code>regex</code>.

**Examples:**

<pre><code>&gt; SELECT split('oneAtwoBthreeC', '[ABC]')
 [&quot;one&quot;,&quot;two&quot;,&quot;three&quot;,&quot;&quot;]
</code></pre>

 
## sqrt

sqrt(expr) - Returns the square root of <code>expr</code>.

**Examples:**

<pre><code>&gt; SELECT sqrt(4)
 2.0
</code></pre>

 
## stack

stack(n, expr1, ..., exprk) - Separates <code>expr1</code>, ..., <code>exprk</code> into <code>n</code> rows.

**Examples:**

<pre><code>&gt; SELECT stack(2, 1, 2, 3)
 1  2
 3  NULL
</code></pre>

 
## std

std(expr) - Returns the sample standard deviation calculated from values of a group.

 
## stddev

stddev(expr) - Returns the sample standard deviation calculated from values of a group.

 
## stddev_pop

stddev_pop(expr) - Returns the population standard deviation calculated from values of a group.

 
## stddev_samp

stddev_samp(expr) - Returns the sample standard deviation calculated from values of a group.

 
## str_to_map

str_to_map(text[, pairDelim[, keyValueDelim]]) - Creates a map after splitting the text into key/value pairs using delimiters. Default delimiters are ',' for <code>pairDelim</code> and ':' for <code>keyValueDelim</code>.

**Examples:**

<pre><code>&gt; SELECT str_to_map('a:1,b:2,c:3', ',', ':')
 map(&quot;a&quot;:&quot;1&quot;,&quot;b&quot;:&quot;2&quot;,&quot;c&quot;:&quot;3&quot;)
&gt; SELECT str_to_map('a')
 map(&quot;a&quot;:null)
</code></pre>

 
## string

string(expr) - Casts the value <code>expr</code> to the target data type <code>string</code>.

 
## struct

struct(col1, col2, col3, ...) - Creates a struct with the given field values.

 
## substr

substr(str, pos[, len]) - Returns the substring of <code>str</code> that starts at <code>pos</code> and is of length <code>len</code>, or the slice of byte array that starts at <code>pos</code> and is of length <code>len</code>.

**Examples:**

<pre><code>&gt; SELECT substr('Spark SQL', 5)
 k SQL
&gt; SELECT substr('Spark SQL', -3)
 SQL
&gt; SELECT substr('Spark SQL', 5, 1)
 k
</code></pre>

 
## substring

substring(str, pos[, len]) - Returns the substring of <code>str</code> that starts at <code>pos</code> and is of length <code>len</code>, or the slice of byte array that starts at <code>pos</code> and is of length <code>len</code>.

**Examples:**

<pre><code>&gt; SELECT substring('Spark SQL', 5)
 k SQL
&gt; SELECT substring('Spark SQL', -3)
 SQL
&gt; SELECT substring('Spark SQL', 5, 1)
 k
</code></pre>

 
## substring_index

substring_index(str, delim, count) - Returns the substring from <code>str</code> before <code>count</code> occurrences of the delimiter <code>delim</code>.
If <code>count</code> is positive, everything to the left of the final delimiter (counting from the
left) is returned. If <code>count</code> is negative, everything to the right of the final delimiter
(counting from the right) is returned. The function substring_index performs a case-sensitive match
when searching for <code>delim</code>.

**Examples:**

<pre><code>&gt; SELECT substring_index('www.apache.org', '.', 2)
 www.apache
</code></pre>

 
## sum

sum(expr) - Returns the sum calculated from values of a group.

 
## tan

tan(expr) - Returns the tangent of <code>expr</code>.

**Examples:**

<pre><code>&gt; SELECT tan(0)
 0.0
</code></pre>

 
## tanh

tanh(expr) - Returns the hyperbolic tangent of <code>expr</code>.

**Examples:**

<pre><code>&gt; SELECT tanh(0)
 0.0
</code></pre>

 
## timestamp

timestamp(expr) - Casts the value <code>expr</code> to the target data type <code>timestamp</code>.

 
## tinyint

tinyint(expr) - Casts the value <code>expr</code> to the target data type <code>tinyint</code>.

 
## to_date

to_date(date_str[, fmt]) - Parses the <code>date_str</code> expression with the <code>fmt</code> expression to
a date. Returns null with invalid input. By default, it follows casting rules to a date if
the <code>fmt</code> is omitted.

**Examples:**

<pre><code>&gt; SELECT to_date('2009-07-30 04:17:52')
 2009-07-30
&gt; SELECT to_date('2016-12-31', 'yyyy-MM-dd')
 2016-12-31
</code></pre>

<strong>Since:</strong> 1.5.0

 
## to_json

to_json(expr[, options]) - Returns a json string with a given struct value

**Examples:**

<pre><code>&gt; SELECT to_json(named_struct('a', 1, 'b', 2))
 {&quot;a&quot;:1,&quot;b&quot;:2}
&gt; SELECT to_json(named_struct('time', to_timestamp('2015-08-26', 'yyyy-MM-dd')), map('timestampFormat', 'dd/MM/yyyy'))
 {&quot;time&quot;:&quot;26/08/2015&quot;}
&gt; SELECT to_json(array(named_struct('a', 1, 'b', 2))
 [{&quot;a&quot;:1,&quot;b&quot;:2}]
&gt; SELECT to_json(map('a', named_struct('b', 1)))
 {&quot;a&quot;:{&quot;b&quot;:1}}
&gt; SELECT to_json(map(named_struct('a', 1),named_struct('b', 2)))
 {&quot;[1]&quot;:{&quot;b&quot;:2}}
&gt; SELECT to_json(map('a', 1))
 {&quot;a&quot;:1}
&gt; SELECT to_json(array((map('a', 1))))
 [{&quot;a&quot;:1}]
</code></pre>

<strong>Since:</strong> 2.2.0

 
## to_timestamp

to_timestamp(timestamp[, fmt]) - Parses the <code>timestamp</code> expression with the <code>fmt</code> expression to
a timestamp. Returns null with invalid input. By default, it follows casting rules to
a timestamp if the <code>fmt</code> is omitted.

**Examples:**

<pre><code>&gt; SELECT to_timestamp('2016-12-31 00:12:00')
 2016-12-31 00:12:00
&gt; SELECT to_timestamp('2016-12-31', 'yyyy-MM-dd')
 2016-12-31 00:00:00
</code></pre>

<strong>Since:</strong> 2.2.0

 
## to_unix_timestamp

to_unix_timestamp(expr[, pattern]) - Returns the UNIX timestamp of the given time.

**Examples:**

<pre><code>&gt; SELECT to_unix_timestamp('2016-04-08', 'yyyy-MM-dd')
 1460041200
</code></pre>

<strong>Since:</strong> 1.6.0

 
## to_utc_timestamp

to_utc_timestamp(timestamp, timezone) - Given a timestamp like '2017-07-14 02:40:00.0', interprets it as a time in the given time zone, and renders that time as a timestamp in UTC. For example, 'GMT+1' would yield '2017-07-14 01:40:00.0'.

**Examples:**

<pre><code>&gt; SELECT to_utc_timestamp('2016-08-31', 'Asia/Seoul')
 2016-08-30 15:00:00
</code></pre>

<strong>Since:</strong> 1.5.0

 
## translate

translate(input, from, to) - Translates the <code>input</code> string by replacing the characters present in the <code>from</code> string with the corresponding characters in the <code>to</code> string.

**Examples:**

<pre><code>&gt; SELECT translate('AaBbCc', 'abc', '123')
 A1B2C3
</code></pre>

 
## trim

trim(str) - Removes the leading and trailing space characters from <code>str</code>.

trim(BOTH trimStr FROM str) - Remove the leading and trailing <code>trimStr</code> characters from <code>str</code>

trim(LEADING trimStr FROM str) - Remove the leading <code>trimStr</code> characters from <code>str</code>

trim(TRAILING trimStr FROM str) - Remove the trailing <code>trimStr</code> characters from <code>str</code>

**Arguments:**

<ul>
<li>str - a string expression</li>
<li>trimStr - the trim string characters to trim, the default value is a single space</li>
<li>BOTH, FROM - these are keywords to specify trimming string characters from both ends of
    the string</li>
<li>LEADING, FROM - these are keywords to specify trimming string characters from the left
    end of the string</li>
<li>TRAILING, FROM - these are keywords to specify trimming string characters from the right
    end of the string</li>
</ul>

**Examples:**

<pre><code>&gt; SELECT trim('    SparkSQL   ')
 SparkSQL
&gt; SELECT trim('SL', 'SSparkSQLS')
 parkSQ
&gt; SELECT trim(BOTH 'SL' FROM 'SSparkSQLS')
 parkSQ
&gt; SELECT trim(LEADING 'SL' FROM 'SSparkSQLS')
 parkSQLS
&gt; SELECT trim(TRAILING 'SL' FROM 'SSparkSQLS')
 SSparkSQ
</code></pre>

 
## trunc

trunc(date, fmt) - Returns <code>date</code> with the time portion of the day truncated to the unit specified by the format model <code>fmt</code>.
<code>fmt</code> should be one of ["year", "yyyy", "yy", "mon", "month", "mm"]

**Examples:**

<pre><code>&gt; SELECT trunc('2009-02-12', 'MM')
 2009-02-01
&gt; SELECT trunc('2015-10-27', 'YEAR')
 2015-01-01
</code></pre>

<strong>Since:</strong> 1.5.0

 
## ucase

ucase(str) - Returns <code>str</code> with all characters changed to uppercase.

**Examples:**

<pre><code>&gt; SELECT ucase('SparkSql')
 SPARKSQL
</code></pre>

 
## unbase64

unbase64(str) - Converts the argument from a base 64 string <code>str</code> to a binary.

**Examples:**

<pre><code>&gt; SELECT unbase64('U3BhcmsgU1FM')
 Spark SQL
</code></pre>

 
## unhex

unhex(expr) - Converts hexadecimal <code>expr</code> to binary.

**Examples:**

<pre><code>&gt; SELECT decode(unhex('537061726B2053514C'), 'UTF-8')
 Spark SQL
</code></pre>

 
## unix_timestamp

unix_timestamp([expr[, pattern]]) - Returns the UNIX timestamp of current or specified time.

**Examples:**

<pre><code>&gt; SELECT unix_timestamp()
 1476884637
&gt; SELECT unix_timestamp('2016-04-08', 'yyyy-MM-dd')
 1460041200
</code></pre>

<strong>Since:</strong> 1.5.0

 
## upper

upper(str) - Returns <code>str</code> with all characters changed to uppercase.

**Examples:**

<pre><code>&gt; SELECT upper('SparkSql')
 SPARKSQL
</code></pre>

 
## uuid

uuid() - Returns an universally unique identifier (UUID) string. The value is returned as a canonical UUID 36-character string.

**Examples:**

<pre><code>&gt; SELECT uuid()
 46707d92-02f4-4817-8116-a4c3b23e6266
</code></pre>

 
## var_pop

var_pop(expr) - Returns the population variance calculated from values of a group.

 
## var_samp

var_samp(expr) - Returns the sample variance calculated from values of a group.

 
## variance

variance(expr) - Returns the sample variance calculated from values of a group.

 
## weekofyear

weekofyear(date) - Returns the week of the year of the given date. A week is considered to start on a Monday and week 1 is the first week with &gt;3 days.

**Examples:**

<pre><code>&gt; SELECT weekofyear('2008-02-20')
 8
</code></pre>

<strong>Since:</strong> 1.5.0

 
when

CASE WHEN expr1 THEN expr2 [WHEN expr3 THEN expr4]* [ELSE expr5] END - When <code>expr1</code> = true, returns <code>expr2</code>; else when <code>expr3</code> = true, returns <code>expr4</code>; else returns <code>expr5</code>.

**Arguments:**

<ul>
<li>expr1, expr3 - the branch condition expressions should all be boolean type.</li>
<li>expr2, expr4, expr5 - the branch value expressions and else value expression should all be
    same type or coercible to a common type.</li>
</ul>
**Examples:**
<pre><code>&gt; SELECT CASE WHEN 1 &gt; 0 THEN 1 WHEN 2 &gt; 0 THEN 2.0 ELSE 1.2 END;
 1
&gt; SELECT CASE WHEN 1 &lt; 0 THEN 1 WHEN 2 &gt; 0 THEN 2.0 ELSE 1.2 END;
 2
&gt; SELECT CASE WHEN 1 &lt; 0 THEN 1 WHEN 2 &lt; 0 THEN 2.0 END;
 NULL
</code></pre>

 
## window
 
## xpath

xpath(xml, xpath) - Returns a string array of values within the nodes of xml that match the XPath expression.

**Examples:**

<pre><code>&gt; SELECT xpath('&lt;a&gt;&lt;b&gt;b1&lt;/b&gt;&lt;b&gt;b2&lt;/b&gt;&lt;b&gt;b3&lt;/b&gt;&lt;c&gt;c1&lt;/c&gt;&lt;c&gt;c2&lt;/c&gt;&lt;/a&gt;','a/b/text()')
 ['b1','b2','b3']
</code></pre>

 
## xpath_boolean

xpath_boolean(xml, xpath) - Returns true if the XPath expression evaluates to true, or if a matching node is found.

**Examples:**

<pre><code>&gt; SELECT xpath_boolean('&lt;a&gt;&lt;b&gt;1&lt;/b&gt;&lt;/a&gt;','a/b')
 true
</code></pre>

 
## xpath_double

xpath_double(xml, xpath) - Returns a double value, the value zero if no match is found, or NaN if a match is found but the value is non-numeric.

**Examples:**

<pre><code>&gt; SELECT xpath_double('&lt;a&gt;&lt;b&gt;1&lt;/b&gt;&lt;b&gt;2&lt;/b&gt;&lt;/a&gt;', 'sum(a/b)')
 3.0
</code></pre>

 
## xpath_float

xpath_float(xml, xpath) - Returns a float value, the value zero if no match is found, or NaN if a match is found but the value is non-numeric.

**Examples:**

<pre><code>&gt; SELECT xpath_float('&lt;a&gt;&lt;b&gt;1&lt;/b&gt;&lt;b&gt;2&lt;/b&gt;&lt;/a&gt;', 'sum(a/b)')
 3.0
</code></pre>

 
## xpath_int

xpath_int(xml, xpath) - Returns an integer value, or the value zero if no match is found, or a match is found but the value is non-numeric.

**Examples:**

<pre><code>&gt; SELECT xpath_int('&lt;a&gt;&lt;b&gt;1&lt;/b&gt;&lt;b&gt;2&lt;/b&gt;&lt;/a&gt;', 'sum(a/b)')
 3
</code></pre>

 
## xpath_long

xpath_long(xml, xpath) - Returns a long integer value, or the value zero if no match is found, or a match is found but the value is non-numeric.

**Examples:**

<pre><code>&gt; SELECT xpath_long('&lt;a&gt;&lt;b&gt;1&lt;/b&gt;&lt;b&gt;2&lt;/b&gt;&lt;/a&gt;', 'sum(a/b)')
 3
</code></pre>

 
## xpath_number

xpath_number(xml, xpath) - Returns a double value, the value zero if no match is found, or NaN if a match is found but the value is non-numeric.

**Examples:**

<pre><code>&gt; SELECT xpath_number('&lt;a&gt;&lt;b&gt;1&lt;/b&gt;&lt;b&gt;2&lt;/b&gt;&lt;/a&gt;', 'sum(a/b)')
 3.0
</code></pre>

 
## xpath_short

xpath_short(xml, xpath) - Returns a short integer value, or the value zero if no match is found, or a match is found but the value is non-numeric.

**Examples:**

<pre><code>&gt; SELECT xpath_short('&lt;a&gt;&lt;b&gt;1&lt;/b&gt;&lt;b&gt;2&lt;/b&gt;&lt;/a&gt;', 'sum(a/b)')
 3
</code></pre>

 
## xpath_string

xpath_string(xml, xpath) - Returns the text contents of the first xml node that matches the XPath expression.

**Examples:**

<pre><code>&gt; SELECT xpath_string('&lt;a&gt;&lt;b&gt;b&lt;/b&gt;&lt;c&gt;cc&lt;/c&gt;&lt;/a&gt;','a/c')
 cc
</code></pre>

 
## year

year(date) - Returns the year component of the date/timestamp.

**Examples:**

<pre><code>&gt; SELECT year('2016-07-30')
 2016
</code></pre>

<strong>Since:</strong> 1.5.0

 
## |

expr1 | expr2 - Returns the result of bitwise OR of <code>expr1</code> and <code>expr2</code>.

**Examples:**

<pre><code>&gt; SELECT 3 | 5;
 7
</code></pre>

 
## ~

~ expr - Returns the result of bitwise NOT of <code>expr</code>.

**Examples:**

<pre><code>&gt; SELECT ~ 0;
 -1
</code></pre>
