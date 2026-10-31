import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:piantala/data/local/collections/pending_operation_collection.dart';
import 'package:piantala/data/local/collections/plant_collection.dart';
import 'package:piantala/data/local/collections/room_collection.dart';
import 'package:piantala/data/local/collections/species_cache_collection.dart';

class IsarService {
  IsarService._();
  static final IsarService instance = IsarService._();
  Isar? _db;

  Isar get db {
    assert(_db != null, 'IsarService non inizializzato.');
    return _db!;
  }

  Future<void> initialize() async {
    if (_db != null) return;
    final dir = await getApplicationDocumentsDirectory();
    _db = await Isar.open(
      [
        PlantCollectionSchema,
        RoomCollectionSchema,
        SpeciesCacheCollectionSchema,
        PendingOperationCollectionSchema,
      ],
      directory: dir.path,
      name: 'piantala_db',
    );
  }

  Future<void> initializeForTesting() async {
    await Isar.initializeIsarCore(download: true);
    _db = await Isar.open(
      [
        PlantCollectionSchema,
        RoomCollectionSchema,
        SpeciesCacheCollectionSchema,
        PendingOperationCollectionSchema,
      ],
      directory: '',
      name: 'test_db',
    );
  }

  Future<void> close() async {
    await _db?.close();
    _db = null;
  }
}
