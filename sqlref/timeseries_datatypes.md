---

copyright:
  years: 2019, 2021
lastupdated: "2021-03-02"

keywords: SQL query, time series, SQL, data types

subcollection: sql-query

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

# Time series data types
{: #ts_datatypes}

Time series functions operate on a wide variety of special data types that are designed especially for time series data.


<div class="section"><div class="p"><div class="tablenoborder"><table cellpadding="4" cellspacing="0" summary="" id="timeseries_datatypes__ts_datatypes" class="table" rules="rows" frame="hsides" border="1"><caption><span class="tablecap">Table 1. Time series data types</span>. <span class="desc tabledesc">These are binary data types especially designed to hold time series data. Alternatively, you can store time series data in any BinaryType data array, such as those offered by Parquet, Avro, ORC, or JSON. CSV does not offer a suitable BinaryType data array for storing time series data.</span></caption><thead class="thead" align="left"><tr class="row"><th class="entry ncol thleft" valign="top" width="19.53125%" id="d2766e29">Data type</th>
<th class="entry ncol thleft" valign="top" width="80.46875%" id="d2766e31">Description</th>
</tr>
</thead>
<tbody class="tbody"><tr class="row"><td class="entry ncol" valign="top" width="19.53125%" headers="d2766e29 ">DoubleTimeSeries</td>
<td class="entry ncol" valign="top" width="80.46875%" headers="d2766e31 ">Time series with univariate observations of type Double, for
example:<pre class="pre codeblock"><code>[(1, 7.2), (3, 4.5), (5, 4.5), (5, 4.6), (5, 7.1), (7, 3.9), (9, 1.1)]</code></pre>
</td>
</tr>
<tr class="row"><td class="entry ncol" valign="top" width="19.53125%" headers="d2766e29 ">DoubleArrayTimeSeries</td>
<td class="entry ncol" valign="top" width="80.46875%" headers="d2766e31 ">Time series with multivariate observations of type Double. See the following example: <pre class="pre codeblock"><code>[(1, [7.2, 8.74]), (3, [4.5, 9.44]), (5, [4.5, 10.12]), (5, [4.6, 12.91]), (5, [7.1, 9.90]), (7, [3.9, 3.76])]</code></pre>
</td>
</tr>
<tr class="row"><td class="entry ncol" valign="top" width="19.53125%" headers="d2766e29 ">DoubleSegmentTimeSeries</td>
<td class="entry ncol" valign="top" width="80.46875%" headers="d2766e31 ">DoubleTimeSeries that is segmented. See the following example:
  <pre class="pre codeblock"><code>[(1,[(1, 7.2), (3, 4.5)]), (5,[(5, 4.5), (5, 4.6), (5, 7.1)]), (7,[(7, 3.9), (9, 1.1)])]</code></pre>
</td>
</tr>
<tr class="row"><td class="entry ncol" valign="top" width="19.53125%" headers="d2766e29 ">DoubleArraySegmentTimeSeries</td>
<td class="entry ncol" valign="top" width="80.46875%" headers="d2766e31 ">DoubleArrayTimeSeries that is segmented.See the following example: <pre class="pre codeblock"><code>[(1,[(1, 7.2, 8.74), (3, 4.5, 9.44)]), (5,[(5, 4.5, 10.12), (5, 4.6, 12.91), (5, 7.1, 9.90)]), (7,[(7, 3.9, 3.76)])]</code></pre>
</td>
</tr>
<tr class="row"><td class="entry ncol" valign="top" width="19.53125%" headers="d2766e29 ">StringTimeSeries</td>
<td class="entry ncol" valign="top" width="80.46875%" headers="d2766e31 ">Time series with univariate observations of type String. See the following example:
<pre class="pre codeblock"><code>[(1, "a"), (3, "b"), (5, "c"), (5, "d"), (5, "e"), (7, "f"), (9, "g")]</code></pre>
</td>
</tr>
<tr class="row"><td class="entry ncol" valign="top" width="19.53125%" headers="d2766e29 ">StringArrayTimeSeries</td>
<td class="entry ncol" valign="top" width="80.46875%" headers="d2766e31 ">Time series with multivariate observations of type String. See the following example:
<pre class="pre codeblock"><code>[(1, ["a", "xq"]), (3, ["b", "zr"]), (5, ["c", "ms"]), (5, ["d", "rt"]), (5, ["e", "wu"]), (7, ["f", "vv"]), (9, ["g", "zw"])]</code></pre>
</td>
</tr>
<tr class="row"><td class="entry ncol" valign="top" width="19.53125%" headers="d2766e29 ">StringSegmentTimeSeries</td>
<td class="entry ncol" valign="top" width="80.46875%" headers="d2766e31 ">StringTimeSeries that is segmented. See the following example:  <pre class="pre codeblock"><code>[(1,[(1, "a"), (3, "b")]), (5,[(5, "c"), (5, "d"), (5, "e")]), (7,[(7, "f"), (9, "g")])]</code></pre>
</td>
</tr>
<tr class="row"><td class="entry ncol" valign="top" width="19.53125%" headers="d2766e29 ">StringArraySegmentTimeSeries</td>
<td class="entry ncol" valign="top" width="80.46875%" headers="d2766e31 ">StringArrayTimeSeries that is segmented. See the following example: <pre class="pre codeblock"><code>[(1,[(1, ["a", "xq"]), (3, ["b", "zr"])]), (5,[(5, ["c", "ms"]), (5, ["d", "rt"]), (5, ["e", "wu"])]), (7, [(7, ["f", "vv"]), (9, ["g", "zw"])])]</code></pre>
</td>
</tr>
</tbody>
</table>
</div>
</div>
</div>

<div class="p"><div class="tablenoborder"><table cellpadding="4" cellspacing="0" summary="" class="table" rules="rows" frame="hsides" border="1"><caption><span class="tablecap">Table 2. Pseudo data types</span>. <span class="desc tabledesc">These are not actual data types, but are placeholders that are used by the documentation to represent any of several time series data types.</span></caption><thead class="thead" align="left"><tr class="row"><th class="entry ncol thleft" valign="top" width="19.53125%" id="d2766e102">Placeholder</th>
<th class="entry ncol thleft" valign="top" width="80.46875%" id="d2766e104">Description</th>
</tr>
</thead>
<tbody class="tbody"><tr class="row"><td class="entry ncol" valign="top" width="19.53125%" headers="d2766e102 "><em class="ph i">TimeSeries</em></td>
<td class="entry ncol" valign="top" width="80.46875%" headers="d2766e104 ">Any of the following data types:<ul class="ul"><li class="li">DoubleTimeSeries</li>
<li class="li">DoubleArrayTimeSeries</li>
<li class="li">DoubleSegmentTimeSeries</li>
<li class="li">DoubleArraySegmentTimeSeries</li>
</ul>
<ul class="ul"><li class="li">StringTimeSeries</li>
<li class="li">StringArrayTimeSeries</li>
<li class="li">StringSegmentTimeSeries</li>
<li class="li">StringArraySegmentTimeSeries</li>
</ul>
</td>
</tr>
<tr class="row"><td class="entry ncol" valign="top" width="19.53125%" headers="d2766e102 "><em class="ph i">SegmentTimeSeries</em></td>
<td class="entry ncol" valign="top" width="80.46875%" headers="d2766e104 ">Any of the following data types:<ul class="ul"><li class="li">DoubleSegmentTimeSeries</li>
<li class="li">DoubleArraySegmentTimeSeries</li>
</ul>
<ul class="ul"><li class="li">StringSegmentTimeSeries</li>
<li class="li">StringArraySegmentTimeSeries</li>
</ul>
</td>
</tr>
<tr class="row"><td class="entry ncol" valign="top" width="19.53125%" headers="d2766e102 "><em class="ph i">ArrayTimeSeries</em></td>
<td class="entry ncol" valign="top" width="80.46875%" headers="d2766e104 ">Any of the following data types:<ul class="ul"><li class="li">DoubleArrayTimeSeries</li>
<li class="li">DoubleArraySegmentTimeSeries</li>
</ul>
<ul class="ul"><li class="li">StringArrayTimeSeries</li>
<li class="li">StringArraySegmentTimeSeries</li>
</ul>
</td>
</tr>
</tbody>
</table>
</div>
</div>

Data type | Description
--- | ---
TRS | A [time reference system (TRS)](/docs/sql-query?topic=sql-query-TRS) defines the granularity of time series timeticks, and defines a start time that maps a particular time series timetick to a corresponding moment in time.
*Table 3. Time reference system data type.*



