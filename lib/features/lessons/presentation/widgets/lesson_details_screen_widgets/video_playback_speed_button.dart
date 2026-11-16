import 'package:al_mobdea/core/style/app_color.dart';
import 'package:al_mobdea/core/style/textstyles.dart';
import 'package:al_mobdea/core/widgets/app_toast.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class VideoPlaybackSpeedButton extends StatefulWidget {
  const VideoPlaybackSpeedButton({super.key, required this.controller});

  final YoutubePlayerController controller;

  @override
  State<VideoPlaybackSpeedButton> createState() {
    return _VideoPlaybackSpeedButtonState();
  }
}

class _VideoPlaybackSpeedButtonState extends State<VideoPlaybackSpeedButton> {
  bool _isOpening = false;

  Future<void> _openSpeedPicker() async {
    if (_isOpening) {
      return;
    }

    setState(() {
      _isOpening = true;
    });

    final controller = widget.controller;

    try {
      final availableRates = await controller.availablePlaybackRates;

      if (!mounted || controller != widget.controller) {
        return;
      }

      if (availableRates.isEmpty) {
        _showError('انتظر تحميل الفيديو ثم حاول مرة أخرى.');
        return;
      }

      final currentRate = await controller.playbackRate;

      if (!mounted || controller != widget.controller) {
        return;
      }

      final rates = availableRates.toSet().toList()..sort();

      final selectedRate = await showModalBottomSheet<double>(
        context: context,
        useRootNavigator: true,
        isScrollControlled: true,
        backgroundColor: ColorPalette.surface,
        showDragHandle: true,
        builder: (sheetContext) {
          return SafeArea(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Material(
                color: ColorPalette.surface,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: Text(
                          'سرعة تشغيل الفيديو',
                          style: AppTextStyle.font16TextPrimarySemiBoldKufam()
                              .copyWith(fontSize: 14),
                        ),
                      ),
                      ...rates.map((rate) {
                        final isSelected = rate == currentRate;

                        return ListTile(
                          dense: true,
                          visualDensity: const VisualDensity(vertical: -2),
                          selected: isSelected,
                          selectedTileColor: ColorPalette.primarySoftBackground,
                          title: Text(
                            rate == 1
                                ? 'السرعة العادية'
                                : '${_formatRate(rate)}x',
                            style: AppTextStyle.font13TextPrimaryMediumTajawal()
                                .copyWith(
                                  fontSize: 13,
                                  color: isSelected
                                      ? ColorPalette.primary
                                      : ColorPalette.textPrimary,
                                ),
                          ),
                          trailing: isSelected
                              ? const Icon(
                                  Icons.check_rounded,
                                  color: ColorPalette.primary,
                                  size: 18,
                                )
                              : null,
                          onTap: () {
                            Navigator.of(sheetContext).pop(rate);
                          },
                        );
                      }),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );

      if (!mounted || controller != widget.controller || selectedRate == null) {
        return;
      }

      await controller.setPlaybackRate(selectedRate);
    } catch (_) {
      _showError('تعذّر تغيير سرعة الفيديو، حاول مرة أخرى.');
    } finally {
      if (mounted) {
        setState(() {
          _isOpening = false;
        });
      }
    }
  }

  String _formatRate(double rate) {
    return rate == rate.roundToDouble()
        ? rate.toInt().toString()
        : rate.toString();
  }

  void _showError(String message) {
    if (!mounted) {
      return;
    }

    showAppToast(context, message: message, icon: Icons.error_outline_rounded);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<YoutubePlayerValue>(
      stream: widget.controller.stream,
      initialData: widget.controller.value,
      builder: (context, snapshot) {
        final rate = snapshot.data?.playbackRate ?? 1.0;

        return TextButton(
          onPressed: _isOpening ? null : _openSpeedPicker,
          style: TextButton.styleFrom(
            foregroundColor: ColorPalette.textLight,
            disabledForegroundColor: ColorPalette.wine100,
            backgroundColor: Colors.black.withValues(alpha: 0.54),
            minimumSize: const Size(48, 36),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            tapTargetSize: MaterialTapTargetSize.padded,
            visualDensity: VisualDensity.compact,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            textDirection: TextDirection.ltr,
            children: [
              const Icon(Icons.speed_rounded, size: 14),
              const SizedBox(width: 4),
              Text(
                '${_formatRate(rate)}x',
                textDirection: TextDirection.ltr,
                style: AppTextStyle.font11TextSecondaryRegularTajawal()
                    .copyWith(
                      fontSize: 10,
                      color: _isOpening
                          ? ColorPalette.wine100
                          : ColorPalette.textLight,
                    ),
              ),
            ],
          ),
        );
      },
    );
  }
}
