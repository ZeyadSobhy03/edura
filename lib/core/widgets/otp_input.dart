import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../resources/colors/color_manger.dart';

class OtpInput extends StatefulWidget {
  const OtpInput({
    super.key,
    required this.controller,
    this.length = 6,
    this.autofocus = false,
    this.validator,
    this.onCompleted,
  });

  final TextEditingController controller;
  final int length;
  final bool autofocus;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onCompleted;

  @override
  State<OtpInput> createState() => _OtpInputState();
}

class _OtpInputState extends State<OtpInput> {
  final FocusNode _focusNode = FocusNode();

  void _refresh() {
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_refresh);
    _focusNode.addListener(_refresh);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_refresh);
    _focusNode.removeListener(_refresh);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      validator: (_) => widget.validator?.call(widget.controller.text),
      builder: (field) {
        final text = widget.controller.text;
        final hasError = field.hasError;
        final activeIndex = text.length.clamp(0, widget.length - 1);
        const spacing = 8.0;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                final available = constraints.maxWidth;
                final boxWidth =
                    ((available - spacing * (widget.length - 1)) /
                            widget.length)
                        .clamp(0.0, 52.0);
                final boxHeight = 56.h;

                return Center(
                  child: SizedBox(
                    width:
                        boxWidth * widget.length +
                        spacing * (widget.length - 1),
                    height: boxHeight,
                    child: Stack(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(widget.length, (i) {
                            final char = i < text.length ? text[i] : '';
                            final isActive =
                                _focusNode.hasFocus && i == activeIndex;

                            Color borderColor = Colors.grey.shade300;
                            double borderWidth = 1;
                            if (hasError) {
                              borderColor = ColorManager.red;
                            } else if (isActive) {
                              borderColor = ColorManager.black;
                              borderWidth = 1.5;
                            }

                            return Container(
                              width: boxWidth,
                              height: boxHeight,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: ColorManager.primaryLight,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: borderColor,
                                  width: borderWidth,
                                ),
                              ),
                              child: Text(
                                char,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: ColorManager.black,
                                ),
                              ),
                            );
                          }),
                        ),
                        Positioned.fill(
                          child: Opacity(
                            opacity: 0,
                            child: TextField(
                              controller: widget.controller,
                              focusNode: _focusNode,
                              autofocus: widget.autofocus,
                              keyboardType: TextInputType.number,
                              autofillHints: const [AutofillHints.oneTimeCode],
                              expands: true,
                              maxLines: null,
                              minLines: null,
                              showCursor: false,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(widget.length),
                              ],
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                counterText: '',
                                contentPadding: EdgeInsets.zero,
                              ),
                              onChanged: (value) {
                                if (field.hasError) field.reset();
                                if (value.length == widget.length) {
                                  widget.onCompleted?.call(value);
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            if (hasError)
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 4),
                child: Text(
                  field.errorText ?? '',
                  style: TextStyle(color: ColorManager.red, fontSize: 12),
                ),
              ),
          ],
        );
      },
    );
  }
}
