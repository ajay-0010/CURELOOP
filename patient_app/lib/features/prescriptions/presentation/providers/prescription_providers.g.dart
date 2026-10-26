// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prescription_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$prescriptionListHash() => r'bef3b08f23fb3f5751d87430451f7da2676fac36';

/// See also [prescriptionList].
@ProviderFor(prescriptionList)
final prescriptionListProvider =
    AutoDisposeFutureProvider<List<Prescription>>.internal(
  prescriptionList,
  name: r'prescriptionListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$prescriptionListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PrescriptionListRef = AutoDisposeFutureProviderRef<List<Prescription>>;
String _$prescriptionDetailHash() =>
    r'c797e442800fba2a7d8b073e9e3a4d8b3ee0e6c0';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [prescriptionDetail].
@ProviderFor(prescriptionDetail)
const prescriptionDetailProvider = PrescriptionDetailFamily();

/// See also [prescriptionDetail].
class PrescriptionDetailFamily extends Family<AsyncValue<Prescription>> {
  /// See also [prescriptionDetail].
  const PrescriptionDetailFamily();

  /// See also [prescriptionDetail].
  PrescriptionDetailProvider call(
    String id,
  ) {
    return PrescriptionDetailProvider(
      id,
    );
  }

  @override
  PrescriptionDetailProvider getProviderOverride(
    covariant PrescriptionDetailProvider provider,
  ) {
    return call(
      provider.id,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'prescriptionDetailProvider';
}

/// See also [prescriptionDetail].
class PrescriptionDetailProvider
    extends AutoDisposeFutureProvider<Prescription> {
  /// See also [prescriptionDetail].
  PrescriptionDetailProvider(
    String id,
  ) : this._internal(
          (ref) => prescriptionDetail(
            ref as PrescriptionDetailRef,
            id,
          ),
          from: prescriptionDetailProvider,
          name: r'prescriptionDetailProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$prescriptionDetailHash,
          dependencies: PrescriptionDetailFamily._dependencies,
          allTransitiveDependencies:
              PrescriptionDetailFamily._allTransitiveDependencies,
          id: id,
        );

  PrescriptionDetailProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  Override overrideWith(
    FutureOr<Prescription> Function(PrescriptionDetailRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PrescriptionDetailProvider._internal(
        (ref) => create(ref as PrescriptionDetailRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Prescription> createElement() {
    return _PrescriptionDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PrescriptionDetailProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin PrescriptionDetailRef on AutoDisposeFutureProviderRef<Prescription> {
  /// The parameter `id` of this provider.
  String get id;
}

class _PrescriptionDetailProviderElement
    extends AutoDisposeFutureProviderElement<Prescription>
    with PrescriptionDetailRef {
  _PrescriptionDetailProviderElement(super.provider);

  @override
  String get id => (origin as PrescriptionDetailProvider).id;
}

String _$safetyCheckHash() => r'63398aa6be7213ccda14c0b40f0e6adce4fb1b7a';

/// See also [safetyCheck].
@ProviderFor(safetyCheck)
const safetyCheckProvider = SafetyCheckFamily();

/// See also [safetyCheck].
class SafetyCheckFamily extends Family<AsyncValue<SafetyResult>> {
  /// See also [safetyCheck].
  const SafetyCheckFamily();

  /// See also [safetyCheck].
  SafetyCheckProvider call(
    String id,
  ) {
    return SafetyCheckProvider(
      id,
    );
  }

  @override
  SafetyCheckProvider getProviderOverride(
    covariant SafetyCheckProvider provider,
  ) {
    return call(
      provider.id,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'safetyCheckProvider';
}

/// See also [safetyCheck].
class SafetyCheckProvider extends AutoDisposeFutureProvider<SafetyResult> {
  /// See also [safetyCheck].
  SafetyCheckProvider(
    String id,
  ) : this._internal(
          (ref) => safetyCheck(
            ref as SafetyCheckRef,
            id,
          ),
          from: safetyCheckProvider,
          name: r'safetyCheckProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$safetyCheckHash,
          dependencies: SafetyCheckFamily._dependencies,
          allTransitiveDependencies:
              SafetyCheckFamily._allTransitiveDependencies,
          id: id,
        );

  SafetyCheckProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  Override overrideWith(
    FutureOr<SafetyResult> Function(SafetyCheckRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SafetyCheckProvider._internal(
        (ref) => create(ref as SafetyCheckRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<SafetyResult> createElement() {
    return _SafetyCheckProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SafetyCheckProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SafetyCheckRef on AutoDisposeFutureProviderRef<SafetyResult> {
  /// The parameter `id` of this provider.
  String get id;
}

class _SafetyCheckProviderElement
    extends AutoDisposeFutureProviderElement<SafetyResult> with SafetyCheckRef {
  _SafetyCheckProviderElement(super.provider);

  @override
  String get id => (origin as SafetyCheckProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
