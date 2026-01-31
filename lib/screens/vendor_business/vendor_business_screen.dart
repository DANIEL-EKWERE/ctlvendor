// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:ctlvendor/screens/vendor_business/controller/vendor_business_controller.dart';

// VendorBusinessController controller = Get.put(VendorBusinessController());

// class VendorBusinessScreen extends StatefulWidget {
//   const VendorBusinessScreen({Key? key}) : super(key: key);

//   @override
//   State<VendorBusinessScreen> createState() => _VendorBusinessScreenState();
// }

// class _VendorBusinessScreenState extends State<VendorBusinessScreen> {
//   Widget _fieldTile(String title, String? value) {
//     return ListTile(title: Text(title), subtitle: Text(value ?? '-'));
//   }

//   Widget _imageTile(String title, String? path) {
//     if (path == null || path.isEmpty) {
//       return ListTile(title: Text(title), subtitle: Text('No file'));
//     }
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//           child: Text(title, style: TextStyle(fontWeight: FontWeight.w600)),
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0),
//           child: SizedBox(
//             height: 180,
//             child: Image.file(File(path), fit: BoxFit.contain),
//           ),
//         ),
//         const SizedBox(height: 12),
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Vendor Business')),
//       body: Obx(() {
//         final m = controller.model.value;
//         if (m == null) {
//           return const Center(child: Text('No business data provided'));
//         }
//         return ListView(
//           children: [
//             // Banner + Profile header
//             Stack(
//               clipBehavior: Clip.none,
//               children: [
//                 Container(
//                   height: 180,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     color: Colors.grey.shade300,
//                     image:
//                         m.businessDocumentPath != null &&
//                             m.businessDocumentPath!.isNotEmpty
//                         ? DecorationImage(
//                             image: FileImage(File(m.businessDocumentPath!)),
//                             fit: BoxFit.cover,
//                           )
//                         : null,
//                   ),
//                   child:
//                       m.businessDocumentPath == null ||
//                           m.businessDocumentPath!.isEmpty
//                       ? Container(
//                           decoration: BoxDecoration(
//                             gradient: LinearGradient(
//                               colors: [
//                                 Colors.blue.shade300,
//                                 Colors.blue.shade700,
//                               ],
//                               begin: Alignment.topLeft,
//                               end: Alignment.bottomRight,
//                             ),
//                           ),
//                           alignment: Alignment.center,
//                           child: Text(
//                             m.businessName ?? 'Vendor',
//                             style: const TextStyle(
//                               color: Colors.white,
//                               fontSize: 20,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         )
//                       : null,
//                 ),
//                 Positioned(
//                   left: 16,
//                   bottom: -36,
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       CircleAvatar(
//                         radius: 44,
//                         backgroundColor: Colors.white,
//                         child: ClipOval(
//                           child: m.logoPath != null && m.logoPath!.isNotEmpty
//                               ? Image.file(
//                                   File(m.logoPath!),
//                                   width: 80,
//                                   height: 80,
//                                   fit: BoxFit.cover,
//                                 )
//                               : Icon(
//                                   Icons.store,
//                                   size: 48,
//                                   color: Colors.grey.shade700,
//                                 ),
//                         ),
//                       ),
//                       const SizedBox(width: 12),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           SizedBox(height: 8),
//                           Text(
//                             m.businessName ?? '-',
//                             style: const TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.w700,
//                             ),
//                           ),
//                           const SizedBox(height: 4),
//                           Row(
//                             children: [
//                               const Icon(
//                                 Icons.location_on,
//                                 size: 14,
//                                 color: Colors.grey,
//                               ),
//                               const SizedBox(width: 4),
//                               SizedBox(
//                                 width: MediaQuery.of(context).size.width - 160,
//                                 child: Text(
//                                   m.businessAddress ?? '-',
//                                   style: TextStyle(color: Colors.grey.shade700),
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 48),

//             // Business Details heading
//             Padding(
//               padding: const EdgeInsets.symmetric(
//                 horizontal: 16.0,
//                 vertical: 8.0,
//               ),
//               child: Text(
//                 'Business Details',
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w700,
//                   color: Colors.grey.shade800,
//                 ),
//               ),
//             ),
//             Card(
//               margin: const EdgeInsets.symmetric(
//                 horizontal: 12.0,
//                 vertical: 4.0,
//               ),
//               child: Column(
//                 children: [
//                   _fieldTile('Business name', m.businessName),
//                   _fieldTile('Business address', m.businessAddress),
//                   _fieldTile('Business type id', m.businessTypeId),
//                   _fieldTile('Fulfilment type', m.fulfilmentType),
//                   _fieldTile('Business description', m.businessDescription),
//                 ],
//               ),
//             ),

//             // Verification heading
//             Padding(
//               padding: const EdgeInsets.symmetric(
//                 horizontal: 16.0,
//                 vertical: 8.0,
//               ),
//               child: Text(
//                 'Verification',
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w700,
//                   color: Colors.grey.shade800,
//                 ),
//               ),
//             ),
//             Card(
//               margin: const EdgeInsets.symmetric(
//                 horizontal: 12.0,
//                 vertical: 4.0,
//               ),
//               child: Column(
//                 children: [
//                   _fieldTile(
//                     'Means of identification',
//                     m.meansOfIdentification,
//                   ),
//                   _fieldTile('Tax number', m.taxNumber),
//                   _fieldTile('BVN', m.bvn),
//                   _fieldTile('Is registered', m.isRegistered ? 'Yes' : 'No'),
//                 ],
//               ),
//             ),

//             const Divider(),
//             _imageTile('Logo', m.logoPath),
//             _imageTile('Business document', m.businessDocumentPath),
//             _imageTile('Identification', m.identificationPath),
//             const SizedBox(height: 24),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: ElevatedButton(
//                 onPressed: () => Navigator.of(context).pop(),
//                 child: const Text('Close'),
//               ),
//             ),
//             const SizedBox(height: 24),
//           ],
//         );
//       }),
//     );
//   }
// }

import 'package:ctlvendor/screens/login/models/models.dart';
import 'package:ctlvendor/widgets/custom_image_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

class VendorBusinessScreen extends StatelessWidget {
  final Vendor? vendor;
  final LoginData? userData;

  const VendorBusinessScreen({Key? key, this.vendor, this.userData})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (vendor == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Business Profile')),
        body: const Center(child: Text('No business data available')),
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: CustomScrollView(
        slivers: [
          // App Bar with Banner
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // Banner Image
                  vendor!.banner != null && vendor!.banner!.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: vendor!.banner!,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              Container(color: Colors.blue.shade700),
                          errorWidget: (context, url, error) => Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.blue.shade400,
                                  Colors.blue.shade700,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                          ),
                        )
                      : Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.blue.shade400,
                                Colors.blue.shade700,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: CustomImageView(imagePath: 'assets/logo.png'),
                        ),
                  // Gradient Overlay
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: Column(
              children: [
                // Profile Header Card
                Transform.translate(
                  offset: const Offset(0, 20),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Card(
                      elevation: .5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            // Logo and Business Name
                            Row(
                              children: [
                                // Logo
                                Container(
                                  width: 80,
                                  height: 80,
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      width: 1,
                                      color: Colors.black12,
                                    ),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child:
                                        vendor!.logo != null &&
                                            vendor!.logo!.isNotEmpty
                                        ? CachedNetworkImage(
                                            imageUrl: vendor!.logo!,
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) =>
                                                const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                            errorWidget:
                                                (context, url, error) => Icon(
                                                  Icons.store,
                                                  size: 40,
                                                  color: Colors.grey[400],
                                                ),
                                          )
                                        : Icon(
                                            Icons.store,
                                            size: 40,
                                            color: Colors.grey[400],
                                          ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                // Business Info
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        vendor!.businessName ?? 'Business Name',
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.location_on,
                                            size: 16,
                                            color: Colors.grey[600],
                                          ),
                                          const SizedBox(width: 4),
                                          Expanded(
                                            child: Text(
                                              vendor!.businessAddress ??
                                                  'No address',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey[600],
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      // Status Badges
                                      Wrap(
                                        alignment: WrapAlignment.start  ,
                                        
                                        spacing: 8,
                                        runSpacing: 8,
                                        children: [
                                          _buildBadge(
                                            vendor!.isVerified == true
                                                ? 'Verified'
                                                : 'Unverified',
                                            vendor!.isVerified == true
                                                ? Colors.green
                                                : Colors.orange,
                                            vendor!.isVerified == true
                                                ? Icons.verified
                                                : Icons.pending,
                                          ),
                                          _buildBadge(
                                            vendor!.isActive == true
                                                ? 'Active'
                                                : 'Inactive',
                                            vendor!.isActive == true
                                                ? Colors.blue
                                                : Colors.grey,
                                            vendor!.isActive == true
                                                ? Icons.check_circle
                                                : Icons.cancel,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // Quick Stats
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 40, 16, 24),
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          'Fulfilment',
                          vendor!.fulfilmentType ?? 'N/A',
                          Icons.delivery_dining,
                          Colors.purple,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildStatCard(
                          'Business Type',
                          _formatBusinessType(vendor!.businessTypeId),
                          Icons.business,
                          Colors.teal,
                        ),
                      ),
                    ],
                  ),
                ),

                // Business Details Section
                _buildSection('Business Details', Icons.store, [
                  _buildDetailRow(
                    'Business Name',
                    vendor!.businessName ?? 'N/A',
                  ),
                  _buildDetailRow(
                    'Email',
                    vendor!.email ?? 'No email provided',
                  ),
                  _buildDetailRow(
                    'Phone Number',
                    vendor!.phoneNumber ?? 'No phone provided',
                  ),
                  _buildDetailRow(
                    'Business Address',
                    vendor!.businessAddress ?? 'No address',
                  ),
                  _buildDetailRow(
                    'Description',
                    vendor!.businessDescription ?? 'No description',
                  ),
                ]),

                // Verification Section
                _buildSection('Verification', Icons.verified_user, [
                  _buildDetailRow(
                    'Registration Status',
                    vendor!.isRegistered == true
                        ? 'Registered'
                        : 'Not Registered',
                  ),
                  _buildDetailRow('Tax Number', vendor!.taxNumber ?? 'N/A'),
                  _buildDetailRow('BVN', vendor!.bvn ?? 'N/A'),
                  _buildDetailRow('RC Number', vendor!.rcNumber ?? 'N/A'),
                  _buildDetailRow(
                    'Means of ID',
                    vendor!.meansOfIdentification?.toUpperCase() ?? 'N/A',
                  ),
                ]),

                // Identification Document
                if (vendor!.identificationUrl != null &&
                    vendor!.identificationUrl!.isNotEmpty)
                  _buildSection(
                    'Identification Document',
                    Icons.card_membership,
                    [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: CachedNetworkImage(
                            imageUrl: vendor!.identificationUrl!,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(
                              height: 200,
                              color: Colors.grey[200],
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                            errorWidget: (context, url, error) => Container(
                              height: 200,
                              color: Colors.grey[200],
                              child: const Center(child: Icon(Icons.error)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                // Locations Section
                if (vendor!.locations != null && vendor!.locations!.isNotEmpty)
                  _buildSection(
                    'Business Locations',
                    Icons.location_city,
                    vendor!.locations!.map((location) {
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: location.isPrimary == true
                                ? Colors.blue
                                : Colors.grey,
                            child: Icon(
                              location.isPrimary == true
                                  ? Icons.star
                                  : Icons.location_on,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          title: Text(
                            location.contactAddress ?? 'No address',
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (location.phoneNumber != null)
                                Text('Phone: ${location.phoneNumber}'),
                              Text(
                                location.isPrimary == true
                                    ? 'Primary Location'
                                    : 'Secondary Location',
                                style: TextStyle(
                                  color: location.isPrimary == true
                                      ? Colors.blue
                                      : Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          trailing: Icon(
                            location.isActive == true
                                ? Icons.check_circle
                                : Icons.cancel,
                            color: location.isActive == true
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                // Category and Plan
                if (vendor!.category != null || vendor!.plan != null)
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        if (vendor!.category != null)
                          Expanded(
                            child: _buildInfoCard(
                              'Category',
                              vendor!.category!.name ?? 'N/A',
                              Icons.category,
                              Colors.orange,
                            ),
                          ),
                        if (vendor!.category != null && vendor!.plan != null)
                          const SizedBox(width: 12),
                        if (vendor!.plan != null)
                          Expanded(
                            child: _buildInfoCard(
                              'Plan',
                              vendor!.plan!.name ?? 'N/A',
                              Icons.workspace_premium,
                              Colors.amber,
                            ),
                          ),
                      ],
                    ),
                  ),

                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(String label, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      // padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(width: 1, color: Colors.black12),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 12),
          Text(
            label,
            style: TextStyle(color: Colors.grey[600], fontSize: 12),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, IconData icon, List<Widget> children) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.blue[700], size: 24),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(width: 1, color: Colors.black12),
            ),
            child: Column(children: children),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      //  padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(width: 1, color: Colors.black12),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 8),
          Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  String _formatBusinessType(String? type) {
    if (type == null) return 'N/A';
    return type
        .split('_')
        .map((word) {
          return word[0].toUpperCase() + word.substring(1);
        })
        .join(' ');
  }
}

// Usage example:
// Get.to(() => VendorBusinessScreen(
//   vendor: loginResponse.data?.vendor,
//   userData: loginResponse.data,
// ));
