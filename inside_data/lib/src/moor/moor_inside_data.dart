import 'dart:io';

import 'package:inside_data/inside_data.dart';
import 'package:drift/native.dart';
import 'package:drift/drift.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'moor_inside_data.g.dart';

/// A media can have many parents, either other "media"s or sections
class MediaParentsTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get mediaId => text()();
  TextColumn get parentMedia => text().nullable()();
  TextColumn get parentSection => text().nullable()();
}

/// Called media table, because that's the most common and concrete usage. But more generally,
/// this is really a content table, and can also hold a "media parent", which is not a section,
/// it's kind of like a section which is content focused, and only contains other media, not
/// other sections.
/// (This corresponds to a custom post type which can be the parent of other posts.)
class MediaTable extends Table {
  /// The post ID if the class is it's own post. Otherwise, taken from media source.
  TextColumn get id => text()();

  TextColumn get source => text()();
  IntColumn get sort => integer()();
  TextColumn get title => text().nullable()();
  TextColumn get description => text().nullable()();

  /// How long the class is, in milliseconds.
  IntColumn get duration => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

class SectionTable extends Table {
  IntColumn get id => integer()();
  TextColumn get parentId => text()();
  IntColumn get sort => integer()();

  /// A section can only have a single parent, but some sections kind of are
  /// in two places. So there's a placeholder section which redirects to the
  /// real section.
  TextColumn get redirectId => text()();

  TextColumn get title => text().nullable()();
  TextColumn get description => text().nullable()();
  IntColumn get count => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Yes, an entire table. To store last upate time. Sue me.
class UpdateTimeTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// Last time DB was updated, in milliseconds since epoch.
  IntColumn get updateTime => integer()();
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'insidedata.sqlite'));
    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: [SectionTable, MediaTable, UpdateTimeTable])
class InsideDatabase extends _$InsideDatabase {
  InsideDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

class MoorInsideData extends SiteDataLayer {
  final SiteDataLoader loader;

  MoorInsideData({required this.loader});

  @override
  Future<void> init() {
    // TODO: implement init
    throw UnimplementedError();
  }

  @override
  Future<Media> media(String id) {
    // TODO: implement media
    throw UnimplementedError();
  }

  @override
  Future<Section> section(String id) {
    // TODO: implement section
    throw UnimplementedError();
  }

  @override
  Future<List<Section>> topLevel() {
    // TODO: implement topLevel
    throw UnimplementedError();
  }
}
