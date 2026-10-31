import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:piantala/core/theme/app_colors.dart';
import 'package:piantala/presentation/providers/species_search_providers.dart';
import 'package:piantala/presentation/widgets/main_scaffold.dart';

class EncyclopediaScreen extends ConsumerStatefulWidget {
  const EncyclopediaScreen({super.key});

  @override
  ConsumerState<EncyclopediaScreen> createState() => _EncyclopediaScreenState();
}

class _EncyclopediaScreenState extends ConsumerState<EncyclopediaScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final searchState = ref.watch(speciesSearchProvider);

    return MainScaffold(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: theme.scaffoldBackgroundColor,
            elevation: 0,
            scrolledUnderElevation: 0,
            title: Text(
              'Enciclopedia',
              style: theme.textTheme.titleLarge?.copyWith(
                fontFamily: 'DMSerifDisplay',
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: (v) =>
                      ref.read(speciesSearchProvider.notifier).search(v),
                  decoration: InputDecoration(
                    hintText: 'Cerca per nome comune o scientifico...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _searchController.clear();
                        ref.read(speciesSearchProvider.notifier).search('');
                      },
                    ),
                    filled: true,
                    fillColor: theme.colorScheme.surface,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppRadius.lg),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),
          ),
          searchState.when(
            loading: () => const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (err, stack) => SliverFillRemaining(
              child: Center(child: Text('Errore: $err')),
            ),
            data: (results) {
              if (results.isEmpty && _searchController.text.isNotEmpty) {
                return const SliverFillRemaining(
                  child: Center(child: Text('Nessuna specie trovata.')),
                );
              }

              if (results.isEmpty) {
                return SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.menu_book_outlined,
                          size: 64,
                          color: theme.colorScheme.primary.withAlpha(100),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Esplora migliaia di piante',
                          style: theme.textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Cerca una specie per visualizzarne i dettagli',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              return SliverPadding(
                padding: const EdgeInsets.all(AppSpacing.md),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final item = results[index];
                      final commonName =
                          (item['common_name'] as String?) ?? 'Sconosciuto';
                      final scientificName =
                          (item['scientific_name'] as String?) ?? '';
                      final imageUrl = (item['default_image']
                          as Map<String, dynamic>?)?['thumbnail'] as String?;

                      return Card(
                        elevation: 0,
                        margin: const EdgeInsets.only(bottom: AppSpacing.sm),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppRadius.lg),
                          side: BorderSide(
                            color: theme.dividerColor.withAlpha(20),
                          ),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(AppSpacing.sm),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(AppRadius.sm),
                            child: imageUrl != null
                                ? CachedNetworkImage(
                                    imageUrl: imageUrl,
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) =>
                                        const CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.eco),
                                  )
                                : Container(
                                    width: 60,
                                    height: 60,
                                    color:
                                        theme.colorScheme.primary.withAlpha(20),
                                    child: Icon(
                                      Icons.eco,
                                      color: theme.colorScheme.primary,
                                    ),
                                  ),
                          ),
                          title: Text(
                            commonName,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            scientificName,
                            style: const TextStyle(fontStyle: FontStyle.italic),
                          ),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () {
                            final apiId = item['pid'] as String?;
                            if (apiId != null) {
                              context.push('/encyclopedia/$apiId');
                            }
                          },
                        ),
                      );
                    },
                    childCount: results.length,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
