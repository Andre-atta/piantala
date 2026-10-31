import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piantala/core/theme/app_colors.dart';
import 'package:piantala/domain/entities/plant_entity.dart';
import 'package:piantala/presentation/providers/plant_providers.dart';
import 'package:piantala/presentation/providers/room_providers.dart';

class EditPlantDialog extends ConsumerStatefulWidget {
  const EditPlantDialog({required this.plant, super.key});
  final PlantEntity plant;

  @override
  ConsumerState<EditPlantDialog> createState() => _EditPlantDialogState();
}

class _EditPlantDialogState extends ConsumerState<EditPlantDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _notesController;
  String? _selectedRoomId;
  late String _cultivationMethod;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.plant.customName);
    _notesController = TextEditingController(text: widget.plant.notes);
    _selectedRoomId = widget.plant.roomId;
    _cultivationMethod = widget.plant.cultivationMethod;
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

    final repo = ref.read(plantRepositoryProvider);

    final updatedPlant = widget.plant.copyWith(
      customName: _nameController.text.trim(),
      notes: _notesController.text.trim().isEmpty
          ? null
          : _notesController.text.trim(),
      roomId: _selectedRoomId ?? 'unassigned',
      cultivationMethod: _cultivationMethod,
    );

    await repo.updatePlant(updatedPlant);

    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  Future<void> _delete() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Elimina Pianta'),
          content: const Text(
            'Sei sicuro di voler eliminare questa pianta? '
            'Questa azione non può essere annullata.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Annulla'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
              child:
                  const Text('Elimina', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );

    if (confirm ?? false) {
      setState(() => _isLoading = true);
      final repo = ref.read(plantRepositoryProvider);
      await repo.deletePlant(widget.plant.id);
      if (mounted) {
        Navigator.of(context).pop(); // Chiude Edit dialog
        Navigator.of(context).pop(); // Torna indietro dalla detail screen
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final roomsAsync = ref.watch(roomsProvider);

    return AlertDialog(
      title: const Text('Modifica Pianta'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nome della pianta',
                ),
              ),
              const SizedBox(height: 16),
              roomsAsync.when(
                data: (rooms) {
                  return DropdownButtonFormField<String>(
                    initialValue: _selectedRoomId,
                    decoration: const InputDecoration(labelText: 'Stanza'),
                    items: [
                      const DropdownMenuItem(
                        value: 'unassigned',
                        child: Text('Nessuna stanza (Non assegnata)'),
                      ),
                      ...rooms.map(
                        (room) => DropdownMenuItem(
                          value: room.id,
                          child: Text(room.name),
                        ),
                      ),
                    ],
                    onChanged: (val) {
                      if (val != null) setState(() => _selectedRoomId = val);
                    },
                  );
                },
                loading: () => const CircularProgressIndicator(),
                error: (e, _) => Text('Errore stanze: $e'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _notesController,
                decoration: const InputDecoration(
                  labelText: 'Note (opzionale)',
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Metodo di coltivazione',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
              const SizedBox(height: 8),
              SegmentedButton<String>(
                segments: const [
                  ButtonSegment(
                    value: 'soil',
                    label: Text('In terra 🪴'),
                    icon: Icon(Icons.grass),
                  ),
                  ButtonSegment(
                    value: 'hydro',
                    label: Text('Idrocoltura 💧'),
                    icon: Icon(Icons.water),
                  ),
                ],
                selected: {_cultivationMethod},
                onSelectionChanged: (sel) {
                  setState(() => _cultivationMethod = sel.first);
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : _delete,
          child: const Text(
            'Elimina',
            style: TextStyle(color: AppColors.error),
          ),
        ),
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
      actionsAlignment: MainAxisAlignment.spaceBetween,
    );
  }
}
