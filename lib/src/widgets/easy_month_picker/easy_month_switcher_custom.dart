import 'package:flutter/material.dart';

import '../../models/models.dart';
import '../../utils/utils.dart';

/// A widget that displays a button for switching to the previous or next month.
class EasyMonthSwitcherCustom extends StatefulWidget {
  EasyMonthSwitcherCustom({
    super.key,
    required this.locale,
    required this.value,
    required this.year,
    required this.initialDate,
    required this.selectedDate,
    this.onMonthChange,
    this.onYearChange,
    this.funcao,
    this.style,
  });

  /// A `String` that represents the locale code to use for formatting the month name in the switcher.
  final String locale;

  /// The currently selected month.
  final EasyMonth? value;
  final int? year;
  DateTime initialDate;
  DateTime selectedDate;

  /// A callback function that is called when the selected month changes.
  final OnMonthChangeCallBack? onMonthChange;
  final OnYearChangeCallBack? onYearChange;


  final VoidCallback? funcao;

  /// The text style applied to the month string.
  final TextStyle? style;

  @override
  State<EasyMonthSwitcherCustom> createState() =>
      _EasyMonthSwitcherCustomState();
}

class _EasyMonthSwitcherCustomState extends State<EasyMonthSwitcherCustom> {
  List<EasyMonth> _yearMonths = [];
  int _currentMonth = 0;
  @override
  void initState() {
    super.initState();
    _yearMonths = EasyDateUtils.getYearMonths(DateTime.now(), widget.locale);
    _currentMonth = widget.value != null ? ((widget.value!.vale - 1)) : 0;
  }

  bool get _isLastMonth => _currentMonth == _yearMonths.length - 1;
  bool get _isFirstMonth => _currentMonth == 0;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    return SizedBox(
      width: screenWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    if (_isFirstMonth) {
                      return;
                    }
                    _currentMonth--;
                    widget.onMonthChange?.call(_yearMonths[_currentMonth]);
                    if (widget.funcao != null) {
                      widget.funcao!();
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 6),
                    alignment: Alignment.centerRight,
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Color(0xFFf4f4f5), width: 1),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons
                            .arrow_back_ios_new_outlined, // Escolha o ícone que você deseja aqui
                        color: Colors.black,
                        // Cor do ícone
                        size: 16, // Tamanho do ícone
                      ),
                    ),
                  ),
                ),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    _yearMonths[_currentMonth].name.replaceAll('.', ''),
                    textAlign: TextAlign.center,
                    style: widget.style,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (_isLastMonth) {
                      return;
                    }
                    _currentMonth++;
                    widget.onMonthChange?.call(_yearMonths[_currentMonth]);
                    if (widget.funcao != null) {
                      widget.funcao!();
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 6),
                    alignment: Alignment.centerRight,
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Color(0xFFf4f4f5), width: 1),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons
                            .arrow_forward_ios_rounded, // Escolha o ícone que você deseja aqui
                        color: Colors.black,
                        // Cor do ícone
                        size: 16, // Tamanho do ícone
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    widget.selectedDate = widget.initialDate;
                    if (widget.onYearChange != null) {
                      widget.onYearChange?.call(widget.selectedDate.year);

                    }
                    print('Ano selecionado: ${widget.selectedDate.year}');
                    print('inicial selecionado: ${widget.initialDate.year}');
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: widget.initialDate.year == widget.selectedDate.year
                        ? Color(0xFF00bac9)
                        : Colors.white, // Cor do interior do contêiner
                    borderRadius:
                        BorderRadius.circular(10.0), // Bordas arredondadas
                  ),

                  // use `isSelected` to specify whether the widget is selected or not.

                  child: Center(
                    child: Text(
                      widget.initialDate.year.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: widget.initialDate.year ==
                                  widget.selectedDate.year
                              ? Colors.white // Color(0xFF00bac9)
                              : Color(0xFF9CA4AB)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    widget.selectedDate = DateTime(
                      widget.initialDate.year + 1,
                      widget.initialDate.month,
                      widget.initialDate.day,
                    );
                    if (widget.onYearChange != null) {

                      widget.onYearChange?.call(widget.selectedDate.year);
                    }
                  });
                  print('Ano selecionado: ${widget.selectedDate.year}');
                  print('DATA selecionado: ${widget.selectedDate}');

                },
                child: Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color:
                        widget.selectedDate.year == widget.initialDate.year + 1
                            ? Color(0xFF00bac9)
                            : Colors.white, // Cor do interior do contêiner
                    borderRadius:
                        BorderRadius.circular(10.0), // Bordas arredondadas
                  ),

                  // use `isSelected` to specify whether the widget is selected or not.

                  child: Center(
                    child: Text(
                      '${widget.initialDate.year + 1}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: widget.initialDate.year ==
                                  widget.selectedDate.year
                              ? Color(0xFF00bac9)
                              : Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
