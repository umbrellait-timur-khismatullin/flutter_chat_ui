import 'dart:io';

import 'package:flutter/material.dart';

import '../state/inherited_chat_theme.dart';
import '../state/inherited_l10n.dart';

/// A class that represents send button widget.
class SendButton extends StatelessWidget {
  /// Creates send button widget.
  const SendButton({
    super.key,
    required this.onPressed,
    this.padding = EdgeInsets.zero,
  });

  /// Callback for send button tap event.
  final VoidCallback onPressed;

  /// Padding around the button.
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) => Container(
        margin: InheritedChatTheme.of(context).theme.sendButtonMargin ??
            EdgeInsetsDirectional.fromSTEB(
              0,
              Platform.isIOS ? 0 : 6,
              6,
              Platform.isIOS ? 0 : 6,
            ),
        child: Container(
          height: 36,
          width: 36,
          decoration: BoxDecoration(
            borderRadius: Platform.isIOS
                ? null
                : const BorderRadius.all(Radius.circular(12)),
            shape: Platform.isIOS ? BoxShape.circle : BoxShape.rectangle,
            color: InheritedChatTheme.of(context).theme.sendBackgroundColor,
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 2),
            child: IconButton(
              // constraints: const BoxConstraints(
              //   minHeight: 24,
              //   minWidth: 24,
              // ),
              icon: InheritedChatTheme.of(context).theme.sendButtonIcon ??
                  Image.asset(
                    'assets/icon-send.png',
                    color: InheritedChatTheme.of(context).theme.inputTextColor,
                    package: 'flutter_chat_ui',
                  ),
              onPressed: onPressed,
              // padding: padding,
              splashRadius: 24,
              tooltip:
                  InheritedL10n.of(context).l10n.sendButtonAccessibilityLabel,
            ),
          ),
        ),
      );
}
