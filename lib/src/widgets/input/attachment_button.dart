import 'package:badges/badges.dart';
import 'package:flutter/material.dart' hide Badge;

import '../state/inherited_chat_theme.dart';
import '../state/inherited_l10n.dart';

/// A class that represents attachment button widget.
class AttachmentButton extends StatelessWidget {
  /// Creates attachment button widget.
  const AttachmentButton({
    super.key,
    this.isLoading = false,
    this.onPressed,
    this.padding = EdgeInsets.zero,
    this.count = 0,
  });

  /// Show a loading indicator instead of the button.
  final bool isLoading;

  /// Callback for attachment button tap event.
  final VoidCallback? onPressed;

  /// Padding around the button.
  final EdgeInsets padding;

  final int? count;

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          Container(
            margin:
                InheritedChatTheme.of(context).theme.attachmentButtonMargin ??
                    const EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
            child: IconButton(
              constraints: const BoxConstraints(
                minHeight: 24,
                minWidth: 24,
              ),
              icon: isLoading
                  ? SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.transparent,
                        strokeWidth: 1.5,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          InheritedChatTheme.of(context)
                              .theme
                              .attachmentBadgeColor,
                        ),
                      ),
                    )
                  : InheritedChatTheme.of(context).theme.attachmentButtonIcon ??
                      Image.asset(
                        'assets/icon-attachment.png',
                        color:
                            InheritedChatTheme.of(context).theme.inputTextColor,
                        package: 'flutter_chat_ui',
                      ),
              onPressed: isLoading ? null : onPressed,
              // padding: padding,
              splashRadius: 24,
              tooltip: InheritedL10n.of(context)
                  .l10n
                  .attachmentButtonAccessibilityLabel,
            ),
          ),
          if (count != 0)
            Positioned(
              right: 3,
              top: 3,
              child: Badge(
                padding: const EdgeInsets.all(6),
                badgeContent: Text(
                  '$count',
                  style: InheritedChatTheme.of(context)
                      .theme
                      .attachmentBadgeTextStyle,
                  textAlign: TextAlign.center,
                ),
                elevation: 0,
                borderSide: InheritedChatTheme.of(context)
                        .theme
                        .attachmentBadgeBorderSide ??
                    BorderSide.none,
                badgeColor:
                    InheritedChatTheme.of(context).theme.attachmentBadgeColor,
              ),
            ),
        ],
      );
}
