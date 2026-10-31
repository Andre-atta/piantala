import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:piantala/core/theme/app_colors.dart';
import 'package:piantala/domain/entities/plant_entity.dart';
import 'package:piantala/domain/entities/room_entity.dart';
import 'package:piantala/presentation/providers/auth_providers.dart';
import 'package:piantala/presentation/providers/plant_providers.dart';
import 'package:piantala/presentation/providers/room_providers.dart';
import 'package:piantala/presentation/providers/species_search_providers.dart';
import 'package:piantala/presentation/widgets/opb_contribution_sheet.dart';
import 'package:uuid/uuid.dart';

class AddPlantScreen extends ConsumerStatefulWidget {
  const AddPlantScreen({super.key});

  @override
  ConsumerState<AddPlantScreen> createState() => _AddPlantScreenState();
}

class _AddPlantScreenState extends ConsumerState<AddPlantScreen> {
  int _currentStep = 0;

  // Step 1: Specie
  final _searchController = TextEditingController();
  Map<String, dynamic>? _selectedSpecies;
  bool _isManualEntry = false;
  final _manualNameController = TextEditingController();

  // Step 1: Metodo di coltivazione
  String _cultivationMethod = 'soil'; // 'soil' | 'hydro'

  // Step 2: Stanza
  String? _selectedRoomId;

  // Step 3: Foto
  File? _selectedImage;
  bool _isSaving = false;

  @override
  void dispose() {
    _searchController.dispose();
    _manualNameController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    ref.read(speciesSearchProvider.notifier).search(value);
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(
      source: source,
      imageQuality: 70, // Compressione
      maxWidth: 1024,
    );
    if (picked != null) {
      setState(() {
        _selectedImage = File(picked.path);
      });
    }
  }

  Future<void> _savePlant() async {
    setState(() => _isSaving = true);
    try {
      final user = ref.read(currentUserProvider);
      if (user == null) throw Exception('Utente non autenticato');

      final repo = ref.read(plantRepositoryProvider);
      final plants = await repo.watchPlants().first;
      final newPosition = plants.length;

      var customName = _manualNameController.text.trim();
      String? speciesApiId;
      String? speciesCommonName;
      String? speciesScientificName;
      String? photoUrl;

      if (_selectedImage != null) {
        final fileName = '${const Uuid().v4()}.jpg';
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('plants_images')
            .child(user.uid)
            .child(fileName);

        await storageRef.putFile(_selectedImage!);
        photoUrl = await storageRef.getDownloadURL();
      }

      if (!_isManualEntry && _selectedSpecies != null) {
        speciesApiId = _selectedSpecies!['pid']?.toString();
        speciesCommonName = _selectedSpecies!['common_name'] as String?;
        final scientific = _selectedSpecies!['scientific_name'];
        if (scientific is String) {
          speciesScientificName = scientific;
        } else if (scientific is List && scientific.isNotEmpty) {
          speciesScientificName = scientific.first.toString();
        }
      }

      // Calcola defaults acqua in base al metodo di coltivazione
      final isHydro = _cultivationMethod == 'hydro';

      // Scarica dettagli da cache se abbiamo apiId
      WateringConfigEntity? wateringConfig;
      if (speciesApiId != null && !isHydro) {
        // Solo per terra: usa frequenza da Perenual
        try {
          final details =
              await ref.read(speciesDetailsProvider(speciesApiId).future);
          wateringConfig = WateringConfigEntity(
            frequencyDays: details['wateringFrequencyDays'] as int? ?? 7,
          );
          if (photoUrl == null && details['imageUrl'] != null) {
            photoUrl = details['imageUrl'] as String?;
          }
        } catch (e) {
          wateringConfig = const WateringConfigEntity(
            frequencyDays: 7,
          );
        }
      } else if (isHydro) {
        // Idrocoltura: ignora API, usa default 3 giorni per cambio/rabbocco
        wateringConfig = const WateringConfigEntity(
          frequencyDays: 3,
        );
        if (speciesApiId != null) {
          // Prova comunque a recuperare la foto dall'API
          try {
            final details =
                await ref.read(speciesDetailsProvider(speciesApiId).future);
            if (photoUrl == null && details['imageUrl'] != null) {
              photoUrl = details['imageUrl'] as String?;
            }
          } catch (_) {}
        }
      } else {
        // Manuale senza specie: default terra 7 giorni
        wateringConfig = const WateringConfigEntity(
          frequencyDays: 7,
        );
      }

      // FertilizingConfig: safe default opzionale
      final fertilizingConfig = FertilizingConfigEntity(
        frequencyDays: isHydro ? 15 : 30,
      );

      final newPlant = PlantEntity(
        id: const Uuid().v4(),
        userId: user.uid,
        roomId: _selectedRoomId ?? 'unassigned',
        customName: customName,
        shelfPosition: newPosition,
        createdAt: DateTime.now(),
        speciesApiId: speciesApiId,
        speciesCommonName: speciesCommonName,
        speciesScientificName: speciesScientificName,
        photoUrl: photoUrl,
        wateringConfig: wateringConfig,
        fertilizingConfig: fertilizingConfig,
        cultivationMethod: _cultivationMethod,
      );

      await repo.addPlant(newPlant);

      if (mounted) {
        if (_isManualEntry || speciesApiId == null) {
          await OpbContributionSheet.show(
            context,
            userId: user.uid,
            plant: newPlant,
            prefillPid: customName,
          );
        }
        if (mounted) {
          context.pop();
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Errore: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Nuova Pianta',
          style: theme.textTheme.titleLarge?.copyWith(
            fontFamily: 'DMSerifDisplay',
          ),
        ),
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: Stepper(
        currentStep: _currentStep,
        onStepContinue: () {
          if (_currentStep == 0) {
            if (!_isManualEntry && _selectedSpecies == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content:
                      Text('Seleziona una specie o usa inserimento manuale'),
                ),
              );
              return;
            }
            if (_isManualEntry && _manualNameController.text.trim().isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Inserisci un nome per la pianta')),
              );
              return;
            }
            setState(() => _currentStep++);
          } else if (_currentStep == 1) {
            if (_selectedRoomId == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Seleziona una stanza')),
              );
              return;
            }
            setState(() => _currentStep++);
          } else if (_currentStep == 2) {
            _savePlant();
          }
        },
        onStepCancel: () {
          if (_currentStep > 0) {
            setState(() => _currentStep--);
          } else {
            context.pop();
          }
        },
        controlsBuilder: (context, details) {
          final isLastStep = _currentStep == 2;
          return Padding(
            padding: const EdgeInsets.only(top: AppSpacing.md),
            child: Row(
              children: [
                FilledButton(
                  onPressed: _isSaving ? null : details.onStepContinue,
                  child: _isSaving
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Text(isLastStep ? 'Salva Pianta' : 'Avanti'),
                ),
                const SizedBox(width: AppSpacing.sm),
                TextButton(
                  onPressed: _isSaving ? null : details.onStepCancel,
                  child: const Text('Indietro'),
                ),
              ],
            ),
          );
        },
        steps: [
          Step(
            title: const Text('Specie'),
            isActive: _currentStep >= 0,
            state: _currentStep > 0 ? StepState.complete : StepState.indexed,
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Selettore metodo di coltivazione ──
                Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Metodo di coltivazione',
                        style: theme.textTheme.labelLarge,
                      ),
                      const SizedBox(height: AppSpacing.xs),
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
                // ── Selezione specie ──
                SwitchListTile(
                  title: const Text('Inserimento manuale'),
                  value: _isManualEntry,
                  onChanged: (val) {
                    setState(() {
                      _isManualEntry = val;
                      _selectedSpecies = null;
                    });
                  },
                ),
                TextField(
                  controller: _manualNameController,
                  decoration: InputDecoration(
                    labelText: _isManualEntry
                        ? 'Nome della pianta (obbligatorio)'
                        : 'Nome personalizzato (opzionale)',
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                if (!_isManualEntry) ...[
                  TextField(
                    controller: _searchController,
                    onChanged: _onSearchChanged,
                    decoration: const InputDecoration(
                      labelText: 'Cerca specie nel database...',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  _buildSearchResults(),
                ],
              ],
            ),
          ),
          Step(
            title: const Text('Stanza'),
            isActive: _currentStep >= 1,
            state: _currentStep > 1 ? StepState.complete : StepState.indexed,
            content: _buildRoomSelection(),
          ),
          Step(
            title: const Text('Foto (opzionale)'),
            isActive: _currentStep >= 2,
            content: Column(
              children: [
                if (_selectedImage != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(AppRadius.md),
                    child: Image.file(
                      _selectedImage!,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  )
                else
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(AppRadius.md),
                    ),
                    child: Icon(
                      Icons.camera_alt,
                      size: 64,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                const SizedBox(height: AppSpacing.md),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      icon: const Icon(Icons.camera),
                      label: const Text('Fotocamera'),
                      onPressed: () => _pickImage(ImageSource.camera),
                    ),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.photo_library),
                      label: const Text('Galleria'),
                      onPressed: () => _pickImage(ImageSource.gallery),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    final searchState = ref.watch(speciesSearchProvider);

    return searchState.when(
      data: (results) {
        if (results.isEmpty && _searchController.text.isNotEmpty) {
          return const Padding(
            padding: EdgeInsets.all(AppSpacing.md),
            child: Text('Nessun risultato trovato.'),
          );
        }
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: results.length > 5 ? 5 : results.length, // Max 5 risultati
          itemBuilder: (context, index) {
            final species = results[index];
            final speciesId = species['pid'] as String?;
            final isSelected = _selectedSpecies?['pid'] == speciesId;
            final dynamic defaultImage = species['default_image'];
            final imageUrl = (defaultImage is Map)
                ? defaultImage['thumbnail'] as String?
                : null;

            return ListTile(
              leading: imageUrl != null
                  ? CircleAvatar(backgroundImage: NetworkImage(imageUrl))
                  : const CircleAvatar(child: Icon(Icons.eco)),
              title: Text((species['common_name'] as String?) ?? 'Sconosciuto'),
              subtitle: Text(
                (species['scientific_name'] as String?) ?? '',
              ),
              trailing: isSelected
                  ? const Icon(Icons.check_circle, color: AppColors.success)
                  : null,
              selected: isSelected,
              onTap: () {
                setState(() {
                  _selectedSpecies = species;
                });
              },
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Text(
        'Errore: $error',
        style: const TextStyle(color: AppColors.error),
      ),
    );
  }

  Widget _buildRoomSelection() {
    final roomsState = ref.watch(roomsProvider);

    return roomsState.when(
      data: (rooms) {
        if (rooms.isEmpty) {
          // Creazione rapida di una stanza di default se non esistono
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Nessuna stanza creata. Ne creeremo una di default.'),
              const SizedBox(height: AppSpacing.sm),
              FilledButton.tonal(
                onPressed: () async {
                  final repo = ref.read(roomRepositoryProvider);
                  final user = ref.read(currentUserProvider);
                  if (user == null) return;
                  final newRoom = RoomEntity(
                    id: const Uuid().v4(),
                    userId: user.uid,
                    name: 'Soggiorno',
                    exposure: 'UNKNOWN',
                    createdAt: DateTime.now(),
                  );
                  await repo.addRoom(newRoom);
                  setState(() {
                    _selectedRoomId = newRoom.id;
                  });
                },
                child: const Text('Crea stanza "Soggiorno"'),
              ),
            ],
          );
        }

        return DropdownButtonFormField<String>(
          initialValue: _selectedRoomId,
          decoration: const InputDecoration(
            labelText: 'Seleziona la stanza',
            border: OutlineInputBorder(),
          ),
          items: rooms.map((r) {
            return DropdownMenuItem(
              value: r.id,
              child: Text(r.name),
            );
          }).toList(),
          onChanged: (val) {
            setState(() {
              _selectedRoomId = val;
            });
          },
        );
      },
      loading: () => const CircularProgressIndicator(),
      error: (err, _) => Text('Errore: $err'),
    );
  }
}
