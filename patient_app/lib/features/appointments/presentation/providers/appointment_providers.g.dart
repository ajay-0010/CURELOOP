// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$upcomingAppointmentsHash() =>
    r'b667231104c2366b6c66bede06afee5b386804ef';

/// See also [upcomingAppointments].
@ProviderFor(upcomingAppointments)
final upcomingAppointmentsProvider =
    AutoDisposeFutureProvider<List<Appointment>>.internal(
  upcomingAppointments,
  name: r'upcomingAppointmentsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$upcomingAppointmentsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UpcomingAppointmentsRef
    = AutoDisposeFutureProviderRef<List<Appointment>>;
String _$pastAppointmentsHash() => r'f2b90874ee86fd81cd67d7c00af23d9d30bea874';

/// See also [pastAppointments].
@ProviderFor(pastAppointments)
final pastAppointmentsProvider =
    AutoDisposeFutureProvider<List<Appointment>>.internal(
  pastAppointments,
  name: r'pastAppointmentsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$pastAppointmentsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PastAppointmentsRef = AutoDisposeFutureProviderRef<List<Appointment>>;
String _$appointmentDetailHash() => r'bda7145fe4b960d35a39b66c033472df9494f1f8';

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

/// See also [appointmentDetail].
@ProviderFor(appointmentDetail)
const appointmentDetailProvider = AppointmentDetailFamily();

/// See also [appointmentDetail].
class AppointmentDetailFamily extends Family<AsyncValue<Appointment>> {
  /// See also [appointmentDetail].
  const AppointmentDetailFamily();

  /// See also [appointmentDetail].
  AppointmentDetailProvider call(
    String id,
  ) {
    return AppointmentDetailProvider(
      id,
    );
  }

  @override
  AppointmentDetailProvider getProviderOverride(
    covariant AppointmentDetailProvider provider,
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
  String? get name => r'appointmentDetailProvider';
}

/// See also [appointmentDetail].
class AppointmentDetailProvider extends AutoDisposeFutureProvider<Appointment> {
  /// See also [appointmentDetail].
  AppointmentDetailProvider(
    String id,
  ) : this._internal(
          (ref) => appointmentDetail(
            ref as AppointmentDetailRef,
            id,
          ),
          from: appointmentDetailProvider,
          name: r'appointmentDetailProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$appointmentDetailHash,
          dependencies: AppointmentDetailFamily._dependencies,
          allTransitiveDependencies:
              AppointmentDetailFamily._allTransitiveDependencies,
          id: id,
        );

  AppointmentDetailProvider._internal(
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
    FutureOr<Appointment> Function(AppointmentDetailRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AppointmentDetailProvider._internal(
        (ref) => create(ref as AppointmentDetailRef),
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
  AutoDisposeFutureProviderElement<Appointment> createElement() {
    return _AppointmentDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AppointmentDetailProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin AppointmentDetailRef on AutoDisposeFutureProviderRef<Appointment> {
  /// The parameter `id` of this provider.
  String get id;
}

class _AppointmentDetailProviderElement
    extends AutoDisposeFutureProviderElement<Appointment>
    with AppointmentDetailRef {
  _AppointmentDetailProviderElement(super.provider);

  @override
  String get id => (origin as AppointmentDetailProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
