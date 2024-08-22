import 'dart:io';

import 'package:admin_socialpulse/models/comment.dart';
import 'package:admin_socialpulse/models/post.dart';
import 'package:admin_socialpulse/models/search_result.dart';
import 'package:admin_socialpulse/models/subscription.dart';
import 'package:admin_socialpulse/models/user.dart';
import 'package:admin_socialpulse/providers/comment_provider.dart';
import 'package:admin_socialpulse/providers/post_provider.dart';
import 'package:admin_socialpulse/providers/subscription_provider.dart';
import 'package:admin_socialpulse/providers/user_provider.dart';
import 'package:admin_socialpulse/utils/utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  bool isLoading = true;
  var today = DateTime.now();

  late UserProvider _userProvider = UserProvider();
  late PostProvider _postProvider = PostProvider();
  late CommentProvider _commentProvider = CommentProvider();
  late SubscriptionProvider _subscriptionProvider = SubscriptionProvider();

  late SearchResult<User>? userResult;
  late SearchResult<Post>? postResult;
  late SearchResult<Comment>? commentResult;
  late SearchResult<Subscription>? subscriptionResult;

  String? selectedData = 'Subscriptions';
  String? selectedMonth = 'All months';
  String? selectedYear = 'All years';
  String? selectedUser = 'All users';

  @override
  void initState() {
    super.initState();

    _userProvider = context.read<UserProvider>();
    _postProvider = context.read<PostProvider>();
    _commentProvider = context.read<CommentProvider>();
    _subscriptionProvider = context.read<SubscriptionProvider>();

    fetchData();
  }

  Future<void> fetchData() async {
    try {
      userResult = await _userProvider.getPaged(
          filter: {'isDeleted': false, 'pageSize': 10000, 'role': "User"});
      postResult = await _postProvider
          .getPaged(filter: {'isDeleted': false, 'pageSize': 10000});
      commentResult = await _commentProvider
          .getPaged(filter: {'isDeleted': false, 'pageSize': 10000});
      subscriptionResult = await _subscriptionProvider
          .getPaged(filter: {'isDeleted': false, 'pageSize': 10000});

      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        alertBoxMoveBack(context, "Error", e.toString());
      }
    }
  }

  List<dynamic> getFilteredData(String dataType) {
    dynamic data;

    if (dataType == "Subscriptions") {
      data = subscriptionResult!.items;
    } else if (dataType == "Posts") {
      data = postResult!.items;
    } else if (dataType == "Comments") {
      data = commentResult!.items;
    }

    if (selectedUser != 'All users') {
      data = data
          .where((dataPoint) => dataPoint.userId.toString() == selectedUser)
          .toList();
    }
    if (selectedMonth != 'All months') {
      data = data
          .where((dataPoint) =>
              dataPoint.createdAt?.month.toString() == selectedMonth)
          .toList();
    }
    if (selectedYear != 'All years') {
      data = data
          .where((dataPoint) =>
              dataPoint.createdAt?.year.toString() == selectedYear)
          .toList();
    }

    return data;
  }

  List<int?> monthsWithData(String dataType) {
    dynamic data;

    if (dataType == "Subscriptions") {
      data = subscriptionResult!.items;
    } else if (dataType == "Posts") {
      data = postResult!.items;
    } else if (dataType == "Comments") {
      data = commentResult!.items;
    }

    if (selectedUser != 'All users') {
      data = data
          .where((dataPoint) => dataPoint.userId.toString() == selectedUser)
          .toList();
    }

    if (selectedYear == 'All years') {
      return data
          .map<int?>((dataPoint) => (dataPoint.createdAt as DateTime).month)
          .toSet()
          .toList();
    } else {
      int? year = int.tryParse(selectedYear!);
      if (year == null) {
        return [];
      }
      return data
          .where((dataPoint) => (dataPoint.createdAt as DateTime).year == year)
          .map<int?>((dataPoint) => (dataPoint.createdAt as DateTime).month)
          .toSet()
          .toList();
    }
  }

  List<int> yearsWithData(String dataType) {
    dynamic data;

    if (dataType == "Subscriptions") {
      data = subscriptionResult!.items;
    } else if (dataType == "Posts") {
      data = postResult!.items;
    } else if (dataType == "Comments") {
      data = commentResult!.items;
    }

    data = data
        .where((dataPoint) =>
            selectedUser == "All users" ||
            dataPoint.userId.toString() == selectedUser)
        .map<int?>((dataPoint) => (dataPoint.createdAt as DateTime).year)
        .whereType<int>()
        .toSet()
        .toList();

    if (data is List<int>) {
      data.sort((a, b) => a.compareTo(b));
    }
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const SpinKitFadingCircle(color: Colors.lightGreen)
        : SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Expanded(
                            child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            hint: const Text("Select data"),
                            value: selectedData,
                            onChanged: (newValue) {
                              setState(() {
                                selectedData = newValue;
                              });
                            },
                            items: const [
                              DropdownMenuItem<String>(
                                  value: "Subscriptions",
                                  child: Text("Subscriptions")),
                              DropdownMenuItem<String>(
                                  value: "Posts", child: Text("Posts")),
                              DropdownMenuItem<String>(
                                  value: "Comments", child: Text("Comments")),
                            ],
                          ),
                        )),
                        const SizedBox(width: 10),
                        Expanded(
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              hint: const Text(
                                'Months',
                              ),
                              value: selectedMonth,
                              onChanged: (newValue) {
                                setState(() {
                                  selectedMonth = newValue;
                                });
                              },
                              items: [
                                const DropdownMenuItem<String>(
                                  value: 'All months',
                                  child: Text('All months',
                                      style: TextStyle(color: Colors.grey)),
                                ),
                                ...List.generate(12, (index) => index + 1)
                                    .map((month) {
                                  bool hasReservations =
                                      monthsWithData(selectedData!)
                                          .contains(month);
                                  return DropdownMenuItem<String>(
                                    value: month.toString(),
                                    child: Row(
                                      children: [
                                        Text(DateFormat.MMM()
                                            .format(DateTime(0, month))),
                                        if (!hasReservations)
                                          const Text(
                                            ' (no data)',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              hint: const Text(
                                'Select year',
                              ),
                              value: selectedYear,
                              onChanged: (newValue) {
                                setState(() {
                                  selectedYear = newValue;
                                });
                              },
                              items: [
                                const DropdownMenuItem<String>(
                                  value: 'All years',
                                  child: Text('All years',
                                      style: TextStyle(color: Colors.grey)),
                                ),
                                ...yearsWithData(selectedData!).map((year) {
                                  dynamic dataType;

                                  if (selectedData == "Subscriptions") {
                                    dataType = subscriptionResult!.items;
                                  } else if (selectedData == "Posts") {
                                    dataType = postResult!.items;
                                  } else if (selectedData == "Comments") {
                                    dataType = commentResult!.items;
                                  }

                                  bool hasData = dataType.any((dataPoint) =>
                                      dataPoint.createdAt?.year == year &&
                                      (selectedMonth == 'All months' ||
                                          dataPoint.createdAt?.month
                                                  .toString() ==
                                              selectedMonth));
                                  return DropdownMenuItem<String>(
                                    value: year.toString(),
                                    child: Row(
                                      children: [
                                        Text(year.toString()),
                                        if (!hasData)
                                          const Text(
                                            ' (no data)',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              hint: const Text(
                                'User',
                              ),
                              value: selectedUser,
                              onChanged: (newValue) {
                                setState(() {
                                  selectedUser = newValue;
                                  selectedYear = 'All years';
                                });
                              },
                              items: [
                                const DropdownMenuItem<String>(
                                  value: 'All users',
                                  child: Text('All users',
                                      style: TextStyle(color: Colors.grey)),
                                ),
                                ...userResult!.items.map((user) {
                                  return DropdownMenuItem<String>(
                                    value: user.id.toString(),
                                    child: Text(user.username!),
                                  );
                                }).toList(),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            margin:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.lightGreen),
                              onPressed: () async {
                                await generateAndDownloadPdf(selectedData!);
                              },
                              child: const Text("Download PDF",
                                  maxLines: 1,
                                  style: TextStyle(color: Colors.black)),
                            ),
                          ),
                        )
                      ],
                    )),
                AnimatedSwitcher(
                  duration: const Duration(seconds: 1),
                  switchInCurve: Curves.bounceIn,
                  switchOutCurve: Curves.easeOut,
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                  child: selectedMonth == null || selectedMonth == "All months"
                      ? buildYearlyBarChart(key: const ValueKey('yearly'))
                      : buildMonthlyLineChart(key: const ValueKey('monthly')),
                ),
              ],
            ),
          );
  }

  Widget buildYearlyBarChart({Key? key}) {
    List<BarChartGroupData> generateBarChartGroups() {
      List<BarChartGroupData> barGroups = [];

      List<dynamic> data = getFilteredData(selectedData!);

      for (int i = 1; i <= 12; i++) {
        double sum = 0;
        for (var dataPoint in data) {
          if (dataPoint.createdAt?.month == i) {
            sum += selectedData == "Subscriptions" ? 5.00 : 1;
          }
        }
        barGroups.add(
          BarChartGroupData(
            x: i,
            barRods: [
              BarChartRodData(
                toY: sum,
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.circular(5),
                width: 15,
              ),
            ],
            showingTooltipIndicators: [0],
          ),
        );
      }
      return barGroups;
    }

    return Container(
      key: key,
      height: 500,
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
      child: BarChart(
        BarChartData(
          groupsSpace: 15,
          barGroups: generateBarChartGroups(),
          borderData: FlBorderData(show: false),
          gridData: FlGridData(
            show: true,
            drawHorizontalLine: true,
            horizontalInterval: 1000,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: Colors.grey.shade300,
                strokeWidth: 1,
              );
            },
          ),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                interval: 1000,
                getTitlesWidget: (value, meta) {
                  return Text(
                    '${value.toInt()}',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey.shade600,
                    ),
                  );
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  return Text(
                    DateFormat.MMM().format(DateTime(0, value.toInt())),
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey.shade600,
                    ),
                  );
                },
                reservedSize: 30,
              ),
            ),
          ),
          minY: 0,
          maxY: 5000,
          barTouchData: BarTouchData(
            touchTooltipData: BarTouchTooltipData(
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                return BarTooltipItem(
                  '${DateFormat.MMM().format(DateTime(0, group.x))}\n${rod.toY.toStringAsFixed(2)}',
                  const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
            touchCallback: (FlTouchEvent event, barTouchResponse) {},
            handleBuiltInTouches: true,
          ),
        ),
      ),
    );
  }

  Widget buildMonthlyLineChart({Key? key}) {
    List<FlSpot> generateLineChartSpots() {
      List<FlSpot> spots = [];

      List<dynamic> data = getFilteredData(selectedData!);

      for (int i = 0; i < 31; i++) {
        double sum = 0;
        for (var dataPoint in data) {
          if (dataPoint.createdAt?.day == i + 1) {
            sum += selectedData == "Subscriptions" ? 5.00 : 1;
          }
        }
        spots.add(FlSpot(i.toDouble(), sum));
      }

      return spots;
    }

    return Container(
      key: key,
      height: 500,
      padding: const EdgeInsets.all(8.0),
      child: LineChart(
        LineChartData(
          borderData: FlBorderData(
              show: true, border: Border.all(color: Colors.grey, width: 1)),
          gridData: FlGridData(
            show: true,
            drawVerticalLine: true,
            drawHorizontalLine: true,
            horizontalInterval: 500,
            verticalInterval: 1,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: Colors.grey.withOpacity(0.5),
                strokeWidth: 0.8,
                dashArray: [5, 5],
              );
            },
            getDrawingVerticalLine: (value) {
              return FlLine(
                color: Colors.grey.withOpacity(0.5),
                strokeWidth: 0.8,
                dashArray: [5, 5],
              );
            },
          ),
          titlesData: FlTitlesData(
            topTitles: const AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                interval: 500,
                getTitlesWidget: (value, meta) {
                  return Text(
                    '${value.toInt()}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  );
                },
              ),
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                interval: 500,
                getTitlesWidget: (value, meta) {
                  return Text(
                    '${value.toInt()}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  );
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 2,
                getTitlesWidget: (double value, TitleMeta meta) {
                  return Text(
                    '${value.toInt() + 1}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  );
                },
              ),
            ),
          ),
          minX: 0,
          maxX: 30,
          minY: 0,
          maxY: 2000,
          lineBarsData: [
            LineChartBarData(
              spots: generateLineChartSpots(),
              isCurved: true,
              color: Colors.blueAccent,
              barWidth: 3,
              belowBarData: BarAreaData(
                show: true,
                color: Colors.blueAccent.withOpacity(0.3),
              ),
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, percent, barData, index) {
                  return FlDotCirclePainter(
                    radius: 4,
                    color: Colors.blueAccent,
                    strokeWidth: 2,
                    strokeColor: Colors.white,
                  );
                },
              ),
            ),
          ],
          lineTouchData: LineTouchData(
            touchTooltipData: LineTouchTooltipData(
              getTooltipItems: (List<LineBarSpot> touchedSpots) {
                return touchedSpots.map((spot) {
                  return LineTooltipItem(
                    '${spot.x.toInt() + 1} dan\n${spot.y.toStringAsFixed(2)}',
                    const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }).toList();
              },
            ),
            touchCallback: (FlTouchEvent event, LineTouchResponse? response) {},
            handleBuiltInTouches: true,
          ),
        ),
      ),
    );
  }

  Future<void> generateAndDownloadPdf(String dataType) async {
    final pdf = pw.Document();
    final dateFormat = DateFormat('dd.MM.yyyy');
    final now = DateTime.now();
    final timestamp = DateFormat('yyyyMMdd_HHmmss').format(now);

    final _selectedYear =
        selectedYear != 'All years' ? selectedYear : 'All years';
    final _selectedMonth =
        selectedMonth != 'All months' ? selectedMonth : 'All months';
    final _selectedUser =
        selectedUser != 'All users' ? selectedUser : 'All users';

    List<dynamic> data = getFilteredData(dataType);

    if (data.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('There is no data with which to generate a report.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Center(
          child: pw.Column(
            mainAxisSize: pw.MainAxisSize.min,
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.Text(
                'Social Pulse Report',
                style: pw.TextStyle(
                  fontSize: 24,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColors.blue800,
                ),
              ),
              pw.SizedBox(height: 10),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Text(
                    'Users: ',
                    style: const pw.TextStyle(
                      fontSize: 16,
                      color: PdfColors.black,
                    ),
                  ),
                  pw.Text(
                    userResult!.items
                            .firstWhere((u) => u.id.toString() == _selectedUser,
                                orElse: () =>
                                    User(null, null, null, null, null, null))
                            .username ??
                        "All users",
                    style: pw.TextStyle(
                      fontSize: 16,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.blue900,
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 5),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Text(
                    'Months: ',
                    style: const pw.TextStyle(
                      fontSize: 16,
                      color: PdfColors.black,
                    ),
                  ),
                  pw.Text(
                    '$selectedMonth',
                    style: pw.TextStyle(
                      fontSize: 16,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.blue900,
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 5),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Text(
                    'Years: ',
                    style: const pw.TextStyle(
                      fontSize: 16,
                      color: PdfColors.black,
                    ),
                  ),
                  pw.Text(
                    '$selectedYear',
                    style: pw.TextStyle(
                      fontSize: 16,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.blue900,
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 10),
              pw.Text(
                'Report generated on: ${dateFormat.format(now)}',
                style: pw.TextStyle(
                  fontSize: 16,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColors.grey900,
                ),
              ),
            ],
          ),
        ),
      ),
    );

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          final filteredData = getFilteredData(dataType);
          final months = monthsWithData(dataType);
          final groupedByUser = groupByUser(filteredData);

          final columnHeaders = <String>['User'];
          if (_selectedMonth != 'All months') {
            final year = _selectedYear != null
                ? int.tryParse(_selectedYear)
                : DateTime.now().year;

            if (year != null) {
              final daysInMonth =
                  DateTime(year, int.parse(_selectedMonth!) + 1, 0).day;
              columnHeaders.addAll(List.generate(
                  daysInMonth, (index) => (index + 1).toString()));
            } else {
              columnHeaders
                  .addAll(List.generate(31, (index) => (index + 1).toString()));
            }
          } else {
            columnHeaders.addAll([
              'Jan',
              'Feb',
              'Mar',
              'Apr',
              'May',
              'Jun',
              'Jul',
              'Aug',
              'Sep',
              'Oct',
              'Nov',
              'Dec'
            ]);
          }
          columnHeaders.add('Total');

          final rows = groupedByUser.entries.map((entry) {
            final user = entry.key;
            final data = entry.value;

            List<String> row = [user.username!];

            if (_selectedMonth != 'All months') {
              final year = _selectedYear != 'All years'
                  ? int.tryParse(_selectedYear!)
                  : DateTime.now().year;

              if (year != null) {
                final daysInMonth =
                    DateTime(year, int.parse(_selectedMonth!) + 1, 0).day;
                final dailyValues = List.generate(daysInMonth, (day) {
                  final dailyTotal = data
                      .where((dataPoint) => dataPoint.createdAt?.day == day + 1)
                      .map((dataPoint) => dataPoint != null
                          ? (dataType == "Subscriptions" ? 5.0 : 1)
                          : 0)
                      .fold(0.0, (prev, curr) => prev + curr);
                  return dailyTotal.toStringAsFixed(
                      dailyTotal.truncateToDouble() == dailyTotal ? 0 : 1);
                });

                final total = dailyValues
                    .map(double.parse)
                    .fold(0.0, (prev, curr) => prev + curr);
                row.addAll(dailyValues);

                if (dailyValues.length < 31) {
                  row.addAll(
                      List.generate(31 - dailyValues.length, (_) => '0'));
                }

                row.add(
                    '${total.toStringAsFixed(total.truncateToDouble() == total ? 0 : 1)} ${dataType == "Subscriptions" ? "\$" : ""}');
              } else {
                row.addAll(List.generate(31, (_) => '0'));
                row.add('0 ${dataType == "Subscriptions" ? "\$" : ""}');
              }
            } else {
              final monthlyValues = List.generate(12, (month) {
                final monthlyTotal = data
                    .where((dataPoint) =>
                        dataPoint.createdAt?.month == (month + 1))
                    .map((dataPoint) => dataPoint != null
                        ? (dataType == "Subscriptions" ? 5.0 : 1)
                        : 0)
                    .fold(0.0, (prev, curr) => prev + curr);
                return monthlyTotal.toStringAsFixed(
                    monthlyTotal.truncateToDouble() == monthlyTotal ? 0 : 1);
              });
              final total = monthlyValues
                  .map(double.parse)
                  .fold(0.0, (prev, curr) => prev + curr);
              row.addAll(monthlyValues);
              row.add(
                  '${total.toStringAsFixed(total.truncateToDouble() == total ? 0 : 1)} ${dataType == "Subscriptions" ? "\$" : ""}');
            }

            final fontSize = _selectedMonth == 'All months' ? 10.0 : 7.5;

            return pw.TableRow(
              children: row.asMap().entries.map((entry) {
                final index = entry.key;
                final cell = entry.value;

                return pw.Container(
                  color: index == 0
                      ? PdfColors.grey300
                      : index == row.length - 1
                          ? PdfColors.grey200
                          : PdfColors.cyan100,
                  child: pw.Padding(
                    padding: const pw.EdgeInsets.all(2),
                    child: pw.Text(
                      cell,
                      style: pw.TextStyle(fontSize: fontSize),
                      textAlign: pw.TextAlign.center,
                      overflow: pw.TextOverflow.clip,
                    ),
                  ),
                );
              }).toList(),
            );
          }).toList();

          final fontSizeHeader = _selectedMonth == 'All months' ? 10.0 : 8.0;
          final columnWidth = _selectedMonth != 'All months' ? 25.0 : 35.0;
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              if (_selectedMonth != 'All months')
                pw.Table(
                  border: pw.TableBorder.all(),
                  columnWidths: {
                    0: const pw.FixedColumnWidth(43),
                    for (int i = 1; i <= 31; i++)
                      i: pw.FixedColumnWidth(columnWidth),
                  },
                  children: [
                    pw.TableRow(
                      children: [
                        pw.Container(
                          alignment: pw.Alignment.center,
                          color: PdfColors.grey300,
                          child: pw.Padding(
                            padding: const pw.EdgeInsets.all(4),
                            child: pw.Text(
                              'Days in the month',
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                  fontSize: fontSizeHeader),
                              textAlign: pw.TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              pw.Table(
                border: pw.TableBorder.all(),
                columnWidths: {
                  0: const pw.FixedColumnWidth(75),
                  for (int i = 1; i < columnHeaders.length; i++)
                    i: pw.FixedColumnWidth(columnWidth),
                  columnHeaders.length - 1: const pw.FixedColumnWidth(75),
                },
                children: [
                  pw.TableRow(
                    children: columnHeaders.asMap().entries.map((entry) {
                      final index = entry.key;
                      final header = entry.value;

                      return pw.Container(
                        color: index == 0
                            ? PdfColors.grey300
                            : index == columnHeaders.length - 1
                                ? PdfColors.grey200
                                : PdfColors.grey300,
                        child: pw.Padding(
                          padding: const pw.EdgeInsets.all(1.5),
                          child: pw.Text(
                            header,
                            style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                                fontSize: fontSizeHeader),
                            textAlign: pw.TextAlign.center,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  ...rows,
                ],
              ),
            ],
          );
        },
      ),
    );

    final result = await FilePicker.platform.saveFile(
      dialogTitle: 'Odaberite mjesto za spremanje PDF-a',
      fileName: 'report_$timestamp.pdf',
    );

    if (result != null) {
      final outputFile = File(result);
      await outputFile.writeAsBytes(await pdf.save());

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('PDF successfully generated.'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Didn\'t select file location.'),
            backgroundColor: Color.fromARGB(255, 167, 148, 5),
          ),
        );
      }
    }
  }

  Map<User, List<dynamic>> groupByUser(List<dynamic> data) {
    final Map<User, List<dynamic>> grouped = {};
    for (var dataPoint in data) {
      final user = userResult!.items.firstWhere((u) => u.id == dataPoint.userId,
          orElse: () => User(null, null, null, null, null, null));
      if (!grouped.containsKey(user)) {
        grouped[user] = [];
      }
      grouped[user]?.add(dataPoint);
    }
    return grouped;
  }
}
