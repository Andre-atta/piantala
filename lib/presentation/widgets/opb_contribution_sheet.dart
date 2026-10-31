import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piantala/core/theme/app_colors.dart';
import 'package:piantala/domain/entities/opb_contribution_entity.dart';
import 'package:piantala/domain/entities/plant_entity.dart';
import 'package:piantala/presentation/providers/opb_contribution_providers.dart';
import 'package:url_launcher/url_launcher.dart';

/// Bottom sheet per raccogliere il consenso e i dati per contribuire
/// a OpenPlantBook.
///
/// Appare dopo il salvataggio di una nuova pianta (senza speciesApiId)
/// o dall'enciclopedia per proporre correzioni a una specie esistente.
///
/// Copy accurato:
///  - NON scrivere "la tua pianta verrà aggiunta al database pubblico"
///  - NON scrivere "verrai accreditato come contributore"
///  - Testo neutro: "dati condivisi con la community OpenPlantBook"
class OpbContributionSheet extends ConsumerStatefulWidget {
  const OpbContributionSheet({
    required this.userId,
    this.plant,
    this.prefillPid,
    this.existingPid, // se non null → modalità update
    super.key,
  });

  final String userId;

  /// Pianta da cui pre-compilare il form (opzionale).
  final PlantEntity? plant;

  /// displayPid pre-compilato (es. dal nome scientifico della pianta).
  final String? prefillPid;

  /// PID esistente su OPB: se valorizzato, il form è in modalità "aggiorna specie".
  final String? existingPid;

  bool get isUpdateMode => existingPid != null;

  /// Apre il bottom sheet e attende che venga chiuso.
  static Future<void> show(
    BuildContext context, {
    required String userId,
    PlantEntity? plant,
    String? prefillPid,
    String? existingPid,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => OpbContributionSheet(
        userId: userId,
        plant: plant,
        prefillPid: prefillPid,
        existingPid: existingPid,
      ),
    );
  }

  @override
  ConsumerState<OpbContributionSheet> createState() =>
      _OpbContributionSheetState();
}

class _OpbContributionSheetState extends ConsumerState<OpbContributionSheet> {
  late final TextEditingController _pidCtrl;
  late final TextEditingController _aliasCtrl;
  late final TextEditingController _categoryCtrl;
  late final TextEditingController _originCtrl;
  late final TextEditingController _sunlightCtrl;
  late final TextEditingController _wateringCtrl;
  late final TextEditingController _fertilizationCtrl;
  late final TextEditingController _pruningCtrl;
  late final TextEditingController _soilCtrl;

  // Campi numerici — usa String per gestire input parziali
  final Map<String, TextEditingController> _numCtrl = {};

  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _pidCtrl = TextEditingController(
      text: widget.prefillPid ?? widget.plant?.speciesScientificName ?? '',
    );
    _aliasCtrl = TextEditingController(
      text: widget.plant?.speciesCommonName ?? '',
    );
    _categoryCtrl = TextEditingController();
    _originCtrl = TextEditingController();
    _sunlightCtrl = TextEditingController();
    _wateringCtrl = TextEditingController();
    _fertilizationCtrl = TextEditingController();
    _pruningCtrl = TextEditingController();
    _soilCtrl = TextEditingController();

    for (final field in [
      'maxTemp',
      'minTemp',
      'maxEnvHumid',
      'minEnvHumid',
      'maxSoilMoist',
      'minSoilMoist',
      'maxLightLux',
      'minLightLux',
      'maxLightMmol',
      'minLightMmol',
      'maxSoilEc',
      'minSoilEc',
    ]) {
      _numCtrl[field] = TextEditingController();
    }
  }

  @override
  void dispose() {
    _pidCtrl.dispose();
    _aliasCtrl.dispose();
    _categoryCtrl.dispose();
    _originCtrl.dispose();
    _sunlightCtrl.dispose();
    _wateringCtrl.dispose();
    _fertilizationCtrl.dispose();
    _pruningCtrl.dispose();
    _soilCtrl.dispose();
    for (final c in _numCtrl.values) {
      c.dispose();
    }
    super.dispose();
  }

  OpbContributionEntity _buildEntity() {
    int? _parseInt(String key) =>
        int.tryParse(_numCtrl[key]?.text.trim() ?? '');

    return OpbContributionEntity(
      displayPid: _pidCtrl.text.trim(),
      alias: _aliasCtrl.text.trim().isEmpty ? null : _aliasCtrl.text.trim(),
      category:
          _categoryCtrl.text.trim().isEmpty ? null : _categoryCtrl.text.trim(),
      origin: _originCtrl.text.trim().isEmpty ? null : _originCtrl.text.trim(),
      maxTemp: _parseInt('maxTemp'),
      minTemp: _parseInt('minTemp'),
      maxEnvHumid: _parseInt('maxEnvHumid'),
      minEnvHumid: _parseInt('minEnvHumid'),
      maxSoilMoist: _parseInt('maxSoilMoist'),
      minSoilMoist: _parseInt('minSoilMoist'),
      maxLightLux: _parseInt('maxLightLux'),
      minLightLux: _parseInt('minLightLux'),
      maxLightMmol: _parseInt('maxLightMmol'),
      minLightMmol: _parseInt('minLightMmol'),
      maxSoilEc: _parseInt('maxSoilEc'),
      minSoilEc: _parseInt('minSoilEc'),
      sunlight:
          _sunlightCtrl.text.trim().isEmpty ? null : _sunlightCtrl.text.trim(),
      watering:
          _wateringCtrl.text.trim().isEmpty ? null : _wateringCtrl.text.trim(),
      fertilization: _fertilizationCtrl.text.trim().isEmpty
          ? null
          : _fertilizationCtrl.text.trim(),
      pruning:
          _pruningCtrl.text.trim().isEmpty ? null : _pruningCtrl.text.trim(),
      soil: _soilCtrl.text.trim().isEmpty ? null : _soilCtrl.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final entity = _buildEntity();
    final validation = ref.watch(validateContributionProvider(entity));

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Material(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle bar
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.outlineVariant,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              Text(
                widget.isUpdateMode
                    ? 'Proponi una correzione'
                    : 'Condividi con la community',
                style: theme.textTheme.titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),

              // ── Copy e link termini ─────────────────────────────────────────
              RichText(
                text: TextSpan(
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  children: [
                    const TextSpan(
                      text:
                          'I dati verranno aggiunti al profilo OpenPlantBook condiviso dell\'app '
                          'e saranno visibili agli altri utenti nelle ricerche. ',
                    ),
                    TextSpan(
                      text: 'Termini di utilizzo OpenPlantBook ↗',
                      style: TextStyle(
                        color: theme.colorScheme.primary,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => launchUrl(
                              Uri.parse('https://open.plantbook.io/terms/'),
                              mode: LaunchMode.externalApplication,
                            ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 12),

              // ── Nome scientifico ────────────────────────────────────────────
              _buildTextField(
                controller: _pidCtrl,
                label: 'Nome scientifico *',
                hint: 'Es. Monstera deliciosa',
                errorText: validation.errors['displayPid'],
                readOnly: widget.isUpdateMode,
              ),

              const SizedBox(height: 12),

              // ── Alias e categoria ───────────────────────────────────────────
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      controller: _aliasCtrl,
                      label: 'Nome comune',
                      errorText: validation.errors['alias'],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildTextField(
                      controller: _categoryCtrl,
                      label: 'Categoria',
                      hint: 'Es. Aroid',
                      errorText: validation.errors['category'],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              _buildTextField(
                controller: _originCtrl,
                label: 'Origine geografica',
                hint: 'Es. Central America',
                errorText: validation.errors['origin'],
              ),

              const SizedBox(height: 16),

              // ── Campi numerici ──────────────────────────────────────────────
              Text('Dati ambientali',
                  style: theme.textTheme.titleSmall
                      ?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(
                'Compila almeno 3 campi numerici per abilitare l\'invio.',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 12),

              _buildNumericPair(
                  'Temperatura (°C)', 'minTemp', 'maxTemp', validation.errors),
              _buildNumericPair('Umidità ambiente (%)', 'minEnvHumid',
                  'maxEnvHumid', validation.errors),
              _buildNumericPair('Umidità substrato (%)', 'minSoilMoist',
                  'maxSoilMoist', validation.errors),
              _buildNumericPair('Luce (lux)', 'minLightLux', 'maxLightLux',
                  validation.errors),
              _buildNumericPair('Luce (mmol/m²/gg)', 'minLightMmol',
                  'maxLightMmol', validation.errors),
              _buildNumericPair(
                  'EC (µS/cm)', 'minSoilEc', 'maxSoilEc', validation.errors),

              // Indicatore campi valorizzati
              const SizedBox(height: 8),
              Text(
                '${validation.filledNumericFieldCount} campo/i numerici valorizzati'
                '${validation.filledNumericFieldCount >= 3 ? ' ✓' : ' (minimo 3)'}',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: validation.filledNumericFieldCount >= 3
                      ? AppColors.success
                      : theme.colorScheme.onSurfaceVariant,
                ),
              ),

              const SizedBox(height: 16),

              // ── Istruzioni di cura testuali ─────────────────────────────────
              Text('Istruzioni di cura (opzionale)',
                  style: theme.textTheme.titleSmall
                      ?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),

              _buildTextField(
                  controller: _sunlightCtrl, label: 'Esposizione solare'),
              const SizedBox(height: 8),
              _buildTextField(controller: _wateringCtrl, label: 'Irrigazione'),
              const SizedBox(height: 8),
              _buildTextField(
                  controller: _fertilizationCtrl,
                  label: 'Concimazione',
                  errorText: validation.errors['fertilization']),
              const SizedBox(height: 8),
              _buildTextField(controller: _pruningCtrl, label: 'Potatura'),
              const SizedBox(height: 8),
              _buildTextField(
                  controller: _soilCtrl,
                  label: 'Substrato',
                  errorText: validation.errors['soil']),

              const SizedBox(height: 24),

              // ── Pulsanti ────────────────────────────────────────────────────
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Salta'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: FilledButton(
                      onPressed: (validation.isValid && !_isSubmitting)
                          ? _submit
                          : null,
                      child: _isSubmitting
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Text(widget.isUpdateMode
                              ? 'Invia correzione'
                              : 'Condividi dati'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submit() async {
    setState(() => _isSubmitting = true);
    try {
      final entity = _buildEntity();
      final controller = ref.read(opbContributionControllerProvider.notifier);

      if (widget.isUpdateMode) {
        await controller.update(
          userId: widget.userId,
          pid: widget.existingPid!,
          partial: entity,
        );
      } else {
        await controller.contribute(
          userId: widget.userId,
          entity: entity,
        );
      }

      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Dati accodati per la condivisione. Verranno inviati in background.',
            ),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Errore: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  // ── Helpers UI ────────────────────────────────────────────────────────────────

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? hint,
    String? errorText,
    bool readOnly = false,
  }) {
    return TextField(
      controller: controller,
      readOnly: readOnly,
      onChanged: (_) =>
          setState(() {}), // triggera rebuild per validazione live
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        errorText: errorText,
        border: const OutlineInputBorder(),
        filled: readOnly,
      ),
    );
  }

  Widget _buildNumericPair(
    String label,
    String minKey,
    String maxKey,
    Map<String, String> errors,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 12)),
          const SizedBox(height: 4),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _numCtrl[minKey],
                  onChanged: (_) => setState(() {}),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Min',
                    errorText: errors[minKey],
                    border: const OutlineInputBorder(),
                    isDense: true,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: _numCtrl[maxKey],
                  onChanged: (_) => setState(() {}),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Max',
                    errorText: errors[maxKey],
                    border: const OutlineInputBorder(),
                    isDense: true,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
