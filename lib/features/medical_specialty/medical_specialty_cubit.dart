import 'package:get_it/get_it.dart';
import 'package:healing_guide_flutter/features/common/future_cubit/future_cubit.dart';
import 'package:healing_guide_flutter/features/medical_specialty/repositories.dart';

class MedicalSpecialtyCubit extends FutureCubit<MedicalSpecialties> {
  MedicalSpecialtyCubit() : super();

  void getSpecialties() {
    runFuture(GetIt.I.get<MedicalSpecialtyRepository>().getAll());
  }
}
