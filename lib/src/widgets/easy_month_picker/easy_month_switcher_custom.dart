import 'package:flutter/material.dart';

import '../../models/models.dart';
import '../../utils/utils.dart';

/// A widget that displays a button for switching to the previous or next month.
class EasyMonthSwitcherCustom extends StatefulWidget {
  const EasyMonthSwitcherCustom({
    super.key,
    required this.locale,
    required this.value,
    this.onMonthChange,
    this.style,
  });

  /// A `String` that represents the locale code to use for formatting the month name in the switcher.
  final String locale;

  /// The currently selected month.
  final EasyMonth? value;

  /// A callback function that is called when the selected month changes.
  final OnMonthChangeCallBack? onMonthChange;

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
      width: screenWidth * 0.3,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              if (_isFirstMonth) {
                return;
              }
              _currentMonth--;
              widget.onMonthChange?.call(_yearMonths[_currentMonth]);
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
          Expanded(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                _yearMonths[_currentMonth].name,
                textAlign: TextAlign.center,
                style: widget.style,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (_isLastMonth) {
                return;
              }
              _currentMonth++;
              widget.onMonthChange?.call(_yearMonths[_currentMonth]);
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
    );
  }
}
