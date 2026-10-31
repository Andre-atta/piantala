import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piantala/domain/entities/room_entity.dart';
import 'package:piantala/presentation/providers/auth_providers.dart';
import 'package:piantala/presentation/providers/room_providers.dart';
import 'package:piantala/presentation/screens/rooms/widgets/compass_scanner_dialog.dart';
import 'package:uuid/uuid.dart';

class RoomDialog extends ConsumerStatefulWidget {
  const RoomDialog({this.room, super.key});
  final RoomEntity? room;

  @override
  ConsumerState<RoomDialog> createState() => _RoomDialogState();
}

class _RoomDialogState extends ConsumerState<RoomDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _notesController;
  String _exposure = 'UNKNOWN';
  int? _floor;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.room?.name);
    _notesController = TextEditingController(text: widget.room?.notes);
    if (widget.room != null) {
      _exposure = widget.room!.exposure;
      _floor = widget.room!.floor;
    }
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

    final repo = ref.read(roomRepositoryProvider);
    final user = ref.read(authStateProvider).valueOrNull;

    if (user == null) {
      setState(() => _isLoading = false);
      return;
    }

    final entity = RoomEntity(
      id: widget.room?.id ?? const Uuid().v4(),
      userId: user.uid,
      name: _nameController.text.trim(),
      exposure: _exposure,
      createdAt: widget.room?.createdAt ?? DateTime.now(),
      floor: _floor,
      notes: _notesController.text.trim().isEmpty
          ? null
          : _notesController.text.trim(),
    );

    if (widget.room == null) {
      await repo.addRoom(entity);
    } else {
      await repo.updateRoom(entity);
    }

    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.room == null ? 'Nuova Stanza' : 'Modifica Stanza'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration:
                    const InputDecoration(labelText: 'Nome della stanza'),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Inserisci un nome' : null,
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: () async {
                  final direction = await showDialog<String>(
                    context: context,
                    builder: (context) => const CompassScannerDialog(),
                  );
                  if (direction != null) {
                    setState(() => _exposure = direction);
                  }
                },
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Esposizione Solare',
                    suffixIcon: Icon(Icons.explore),
                  ),
                  child: Text(_exposure),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: _floor?.toString(),
                decoration:
                    const InputDecoration(labelText: 'Piano (opzionale)'),
                keyboardType: TextInputType.number,
                onChanged: (v) => _floor = int.tryParse(v),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _notesController,
                decoration:
                    const InputDecoration(labelText: 'Note (opzionale)'),
                maxLines: 3,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Annulla'),
        ),
        ElevatedButton(
          onPressed: _isLoading ? null : _save,
          child: _isLoading
              ? const CircularProgressIndicator()
              : const Text('Salva'),
        ),
      ],
    );
  }
}
