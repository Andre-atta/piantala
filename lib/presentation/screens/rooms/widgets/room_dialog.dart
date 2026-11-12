import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piantala/core/theme/app_colors.dart';
import 'package:piantala/core/theme/build_context_extensions.dart';
import 'package:piantala/domain/entities/room_entity.dart';
import 'package:piantala/l10n/app_localizations.dart';
import 'package:piantala/presentation/providers/auth_providers.dart';
import 'package:piantala/presentation/providers/room_providers.dart';
import 'package:piantala/presentation/screens/rooms/widgets/compass_scanner_dialog.dart';
import 'package:piantala/presentation/screens/rooms/widgets/room_dialog_metrics.dart';
import 'package:piantala/presentation/screens/rooms/widgets/room_pin_button.dart';
import 'package:piantala/presentation/utils/exposure_localization.dart';
import 'package:piantala/presentation/widgets/common/hanging_tag.dart';
import 'package:piantala/presentation/widgets/common/paper_dialog.dart';
import 'package:piantala/presentation/widgets/common/paper_dialog_scaffold.dart';
import 'package:piantala/presentation/widgets/common/paper_text_field.dart';
import 'package:uuid/uuid.dart';

class RoomDialog extends ConsumerStatefulWidget {
  const RoomDialog({this.room, super.key});

  final RoomEntity? room;

  @override
  ConsumerState<RoomDialog> createState() => _RoomDialogState();
}

class _RoomDialogState extends ConsumerState<RoomDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _notesController;
  String _exposure = 'UNKNOWN';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.room?.name);
    _notesController = TextEditingController(text: widget.room?.notes);
    _exposure = widget.room?.exposure ?? 'UNKNOWN';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    try {
      final repository = ref.read(roomRepositoryProvider);
      final user = ref.read(authStateProvider).valueOrNull;
      if (user == null) return;

      final room = RoomEntity(
        id: widget.room?.id ?? const Uuid().v4(),
        userId: user.uid,
        name: _nameController.text.trim(),
        exposure: _exposure,
        createdAt: widget.room?.createdAt ?? DateTime.now().toUtc(),
        notes: _notesController.text.trim().isEmpty
            ? null
            : _notesController.text.trim(),
      );

      if (widget.room == null) {
        await repository.addRoom(room);
      } else {
        await repository.updateRoom(room);
      }

      if (mounted) Navigator.of(context).pop();
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _detectExposure() async {
    final direction = await showPaperDialog<String>(
      context: context,
      builder: (context) => const CompassScannerDialog(),
    );
    if (direction != null && mounted) {
      setState(() => _exposure = direction);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.piantala;
    final l10n = AppLocalizations.of(context)!;
    final isEditing = widget.room != null;

    return PaperDialogScaffold(
      title: isEditing ? l10n.roomDialogEditTitle : l10n.roomDialogNewTitle,
      actions: [
        HangingTag(
          key: const ValueKey('room-dialog-cancel'),
          label: l10n.commonCancel,
          variant: HangingTagVariant.secondary,
          mirrored: true,
          onPressed: () => Navigator.of(context).pop(),
        ),
        HangingTag(
          key: const ValueKey('room-dialog-save'),
          label: l10n.commonSave,
          onPressed: _isLoading ? null : _save,
        ),
      ],
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            PaperTextField(
              fieldKey: const ValueKey('room-dialog-name-field'),
              label: l10n.roomDialogNameLabel,
              hintText: l10n.roomDialogNameHint,
              controller: _nameController,
              autofocus: true,
              textCapitalization: TextCapitalization.words,
              validator: (value) => value == null || value.trim().isEmpty
                  ? l10n.roomDialogNameValidation
                  : null,
            ),
            const SizedBox(height: RoomDialogMetrics.sectionSpacing),
            _FieldLabel(text: l10n.roomDialogExposureLabel),
            const SizedBox(height: RoomDialogMetrics.labelSpacing),
            SizedBox(
              height: RoomDialogMetrics.exposureRowHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: theme.ink,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        localizedExposure(_exposure, l10n),
                        style: theme.body.copyWith(
                          color: theme.ink,
                          fontSize: RoomDialogMetrics.nameFieldFontSize,
                        ),
                      ),
                    ),
                    RoomPinButton(
                      label: l10n.roomDialogCompassSemantics,
                      onPressed: _detectExposure,
                      child: Icon(
                        Icons.explore_outlined,
                        color: theme.cream,
                        size: RoomDialogMetrics.compassIconSize,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: RoomDialogMetrics.sectionSpacing),
            _FieldLabel(text: l10n.roomDialogNotesLabel),
            const SizedBox(height: RoomDialogMetrics.labelSpacing),
            SizedBox(
              height: RoomDialogMetrics.notesLineHeight *
                  RoomDialogMetrics.notesLineCount,
              child: CustomPaint(
                painter: _NotesLinesPainter(
                  color: theme.leafGreen.withValues(
                    alpha: RoomDialogMetrics.notesLineOpacity,
                  ),
                ),
                child: TextFormField(
                  key: const ValueKey('room-dialog-notes-field'),
                  controller: _notesController,
                  minLines: RoomDialogMetrics.notesLineCount,
                  maxLines: RoomDialogMetrics.notesLineCount,
                  style: theme.body.copyWith(
                    color: theme.ink,
                    fontSize: RoomDialogMetrics.notesFontSize,
                  ),
                  cursorColor: theme.deepGreen,
                  decoration: InputDecoration(
                    hintText: l10n.roomDialogNotesHint,
                    hintStyle: theme.body.copyWith(
                      color: theme.softInk,
                      fontSize: RoomDialogMetrics.notesFontSize,
                    ),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: const EdgeInsets.only(
                      top: RoomDialogMetrics.ruledNotesTopPadding,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = context.piantala;
    return Text(
      text.toUpperCase(),
      style: theme.label.copyWith(
        color: theme.deepGreen,
        letterSpacing: RoomDialogMetrics.fieldLabelLetterSpacing,
      ),
    );
  }
}

class _NotesLinesPainter extends CustomPainter {
  const _NotesLinesPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = AppStroke.hairline;
    for (var index = 1; index <= RoomDialogMetrics.notesLineCount; index++) {
      final y = index * RoomDialogMetrics.notesLineHeight;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(_NotesLinesPainter oldDelegate) =>
      color != oldDelegate.color;
}
