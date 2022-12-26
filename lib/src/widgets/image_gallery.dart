import 'package:flutter/material.dart';
import 'state/inherited_chat_theme.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../conditional/conditional.dart';
import '../models/preview_image.dart';

class ImageGallery extends StatelessWidget {
  const ImageGallery({
    super.key,
    this.imageHeaders,
    required this.images,
    required this.onClosePressed,
    this.options = const ImageGalleryOptions(),
    required this.pageController,
  });

  /// See [Chat.imageHeaders].
  final Map<String, String>? imageHeaders;

  /// Images to show in the gallery.
  final List<PreviewImage> images;

  /// Triggered when the gallery is swiped down or closed via the icon.
  final VoidCallback onClosePressed;

  /// Customisation options for the gallery.
  final ImageGalleryOptions options;

  /// Page controller for the image pages.
  final PageController pageController;

  @override
  Widget build(BuildContext context) => WillPopScope(
      onWillPop: () async {
        onClosePressed();
        return false;
      },
      child: Dismissible(
        key: const Key('photo_view_gallery'),
        direction: DismissDirection.down,
        onDismissed: (direction) => onClosePressed(),
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                gradient: InheritedChatTheme.of(context)
                    .theme
                    .imageBackGroundGradient,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 64),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height -
                      InheritedChatTheme.of(context).theme.inputMargin.bottom -
                      (MediaQuery.of(context).padding.top + 64),
                  child: PhotoViewGallery.builder(
                    backgroundDecoration:
                        const BoxDecoration(color: Colors.transparent),
                    builder: (BuildContext context, int index) =>
                        PhotoViewGalleryPageOptions(
                      imageProvider: Conditional().getProvider(
                        images[index].uri,
                        headers: imageHeaders,
                      ),
                      minScale: options.minScale,
                      maxScale: options.maxScale,
                    ),
                    itemCount: images.length,
                    loadingBuilder: (context, event) =>
                        _imageGalleryLoadingBuilder(event),
                    pageController: pageController,
                    scrollPhysics: const ClampingScrollPhysics(),
                  ),
                ),
              ),
            ),
            Positioned.directional(
              end: 16,
              textDirection: Directionality.of(context),
              top: 16,
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: InheritedChatTheme.of(context)
                      .theme
                      .attachmentBadgeColor
                      .withOpacity(0.8),
                  shape: BoxShape.circle,
                ),
                child: GestureDetector(
                  onTap: onClosePressed,
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

  Widget _imageGalleryLoadingBuilder(ImageChunkEvent? event) => Center(
        child: SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            value: event == null || event.expectedTotalBytes == null
                ? 0
                : event.cumulativeBytesLoaded / event.expectedTotalBytes!,
          ),
        ),
      );
}

class ImageGalleryOptions {
  const ImageGalleryOptions({
    this.maxScale,
    this.minScale,
  });

  /// See [PhotoViewGalleryPageOptions.maxScale].
  final dynamic maxScale;

  /// See [PhotoViewGalleryPageOptions.minScale].
  final dynamic minScale;
}
