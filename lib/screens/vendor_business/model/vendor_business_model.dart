import 'package:ctlvendor/screens/business_screen/controller/business_controller.dart';

class VendorBusinessModel {
  final String businessName;
  final String businessAddress;
  final String businessTypeId;
  final String fulfilmentType;
  final String meansOfIdentification;
  final String taxNumber;
  final String businessDescription;
  final String bvn;
  final bool isRegistered;
  final String? logoPath;
  final String? businessDocumentPath;
  final String? identificationPath;

  VendorBusinessModel({
    required this.businessName,
    required this.businessAddress,
    required this.businessTypeId,
    required this.fulfilmentType,
    required this.meansOfIdentification,
    required this.taxNumber,
    required this.businessDescription,
    required this.bvn,
    required this.isRegistered,
    this.logoPath,
    this.businessDocumentPath,
    this.identificationPath,
  });

  factory VendorBusinessModel.fromBusinessController(BusinessController bc) {
    return VendorBusinessModel(
      businessName: bc.businessNameController.text,
      businessAddress: bc.contactAddressController.text,
      businessTypeId: bc.businessType.value,
      fulfilmentType: bc.fulfilmentType.value,
      meansOfIdentification: bc.meansOfIdentification.value,
      taxNumber: bc.taxNoController.text,
      businessDescription: bc.businessDescriptionController.text,
      bvn: bc.bvnController.text,
      isRegistered: bc.isBusinessRegistered.value,
      logoPath: bc.businessLogoFile.value?.path,
      businessDocumentPath: bc.businessDocumentFile.value?.path,
      identificationPath: bc.identificationFile.value?.path,
    );
  }

  Map<String, dynamic> toJson() => {
    'business_name': businessName,
    'business_address': businessAddress,
    'business_type_id': businessTypeId,
    'fulfilment_type': fulfilmentType,
    'means_of_identification': meansOfIdentification,
    'tax_number': taxNumber,
    'business_description': businessDescription,
    'bvn': bvn,
    'is_registered': isRegistered ? 1 : 0,
    'logo_path': logoPath,
    'business_document_path': businessDocumentPath,
    'identification_path': identificationPath,
  };
}
