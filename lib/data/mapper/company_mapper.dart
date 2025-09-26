import 'package:network/data/model/company_model.dart';
import 'package:network/domain/entity/company_entity.dart';

class CompanyMapper {
  CompanyEntity map(CompanyModel from) {
    return CompanyEntity(
      name: from.name ?? '',
      catchPhrase: from.catchPhrase ?? '',
      bs: from.bs ?? '',
    );
  }
}
