import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:piantala/core/theme/build_context_extensions.dart';
import 'package:piantala/core/utils/plant_asset_resolver.dart';
import 'package:piantala/domain/entities/plant_entity.dart';
import 'package:piantala/presentation/screens/home/widgets/shelf_cabinet.dart';

/// Compatibilità con i test/widget esistenti: compone sfondo e armadio.
class PlantShelfView extends StatelessWidget {
  const PlantShelfView({
    required this.plants,
    super.key,
  });

  final List<PlantEntity> plants;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          PlantAssetResolver.wallBackground(),
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => ColoredBox(
            color: context.piantala.stickWoodAndReserveWall,
          ),
        ),
        ShelfCabinet(
          plants: plants,
          now: DateTime.now(),
          onPlantTap: (plant) => context.go('/plants/${plant.id}'),
        ),
      ],
    );
  }
}
