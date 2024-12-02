// import 'package:account_saver/database/database_provider.dart';
// import 'package:account_saver/ui/widgets/edit_bank_info_sheet.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:url_launcher/url_launcher.dart';

// class BankAccountTile extends StatefulWidget {
//   final String accountNumber;
//   final String category;
//   final String iban;
//   final String relation;
//   final String phoneNumber;
//   final String accountHolderName;
//   final String bankName;
//   final Map<String, dynamic> account;
//   final void Function() onDelete;

//   const BankAccountTile({
//     super.key,
//     required this.accountNumber,
//     required this.category,
//     required this.iban,
//     required this.relation,
//     required this.phoneNumber,
//     required this.accountHolderName,
//     required this.bankName,
//     required this.account,
//     required this.onDelete,
//   });

//   @override
//   // ignore: library_private_types_in_public_api
//   _BankAccountTileState createState() => _BankAccountTileState();
// }

// class _BankAccountTileState extends State<BankAccountTile> {
//   bool _isFavorite = false;
//   bool _isExpanded = false;

//   @override
//   void initState() {
//     super.initState();
//     _isFavorite = widget.account['favorite'] == 1;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<DatabaseProvider>(
//       builder: (context, provider, child) {
//         // Ensure _isFavorite is updated based on provider state
//         _isFavorite = provider.bankAccounts.firstWhere((account) =>
//                 account['id'] == widget.account['id'])['favorite'] ==
//             1;

//         return Card(
//           color: const Color.fromARGB(255, 228, 226, 226),
//           margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
//           elevation: 2.0,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(8.0),
//           ),
//           child: ExpansionTile(
//             title: Text(
//               "${widget.accountHolderName} | ${widget.accountNumber} | ${widget.category}",
//               style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//             ),
//             trailing: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 IconButton(
//                   icon: Icon(
//                     Icons.star,
//                     color: _isFavorite ? Colors.amber : Colors.black,
//                     size: 25.0, // Increased icon size
//                   ),
//                   onPressed: () {
//                     setState(() {
//                       _isFavorite = !_isFavorite;
//                     });
//                     provider.toggleFavorite(widget.account['id'], _isFavorite);
//                   },
//                 ),
//                 Icon(
//                   _isExpanded ? Icons.expand_less : Icons.expand_more,
//                   size: 32.0, // Increased icon size
//                 ),
//               ],
//             ),
//             onExpansionChanged: (expanded) {
//               setState(() {
//                 _isExpanded = expanded;
//               });
//             },
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(
//                     12.0), // Reduced padding to decrease height
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           SelectableText(
//                               'Account Holder: ${widget.accountHolderName}',
//                               style:
//                                   const TextStyle(fontWeight: FontWeight.bold)),
//                           const SizedBox(height: 4.0),
//                           SelectableText('Bank Name: ${widget.bankName}'),
//                           const SizedBox(height: 4.0),
//                           SelectableText('Category: ${widget.category}'),
//                           const SizedBox(height: 4.0),
//                           SelectableText('IBAN: ${widget.iban}'),
//                           const SizedBox(height: 4.0),
//                           SelectableText('Relation: ${widget.relation}'),
//                           const SizedBox(height: 4.0),
//                           SelectableText('Phone Number: ${widget.phoneNumber}'),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(
//                         width: 8.0), // Space between content and icon
//                     IconButton(
//                       icon: const Icon(Icons.credit_card),
//                       onPressed: () {
//                         // Define your card icon action here
//                       },
//                       iconSize: 80.0, // Increased icon size
//                     ),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(
//                     horizontal: 16.0,
//                     vertical: 4.0), // Reduced padding to decrease height
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     IconButton(
//                       icon: const Icon(
//                         Icons.share,
//                         color: Colors.blue,
//                       ),
//                       onPressed: () async {
//                         openBrowser("https://google.com", context);
//                       },
//                       tooltip: 'Share',
//                     ),
//                     const SizedBox(width: 8.0), // Space between icons
//                     IconButton(
//                       icon: const Icon(
//                         Icons.delete,
//                         color: Colors.red,
//                       ),
//                       onPressed: () async {
//                         await provider.deleteBankAccount(widget.account['id']);
//                         widget
//                             .onDelete(); // Trigger any additional delete actions
//                       },
//                       tooltip: 'Delete',
//                     ),
//                     const SizedBox(width: 8.0), // Space between icons
//                     IconButton(
//                       icon: const Icon(Icons.edit),
//                       onPressed: () async {
//                         showModalBottomSheet(
//                           context: context,
//                           builder: (context) => BankAccountEditSheet(
//                             account: widget.account,
//                           ),
//                         );
//                       },
//                       tooltip: 'Delete',
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Future<void> openBrowser(String url, BuildContext context) async {
//     final Uri uri = Uri.parse(url);

//     try {
//       if (await canLaunchUrl(uri)) {
//         await launchUrl(uri);
//       } else {
//         throw 'Could not launch $url';
//       }
//     } catch (e) {
//       // ignore: use_build_context_synchronously
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to open browser. Error: $e')),
//       );
//     }
//   }
// }
import 'package:account_saver/core/constants/media_query.dart';
import 'package:account_saver/database/database_provider.dart';
import 'package:account_saver/ui/widgets/detail_information_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';

import 'edit_bank_info_sheet.dart';

class BankAccountTile extends StatefulWidget {
  final String accountNumber;
  final String category;
  final String iban;
  final String relation;
  final String phoneNumber;
  final String accountHolderName;
  final String bankName;
  final Map<String, dynamic> account;

  const BankAccountTile({
    super.key,
    required this.accountNumber,
    required this.category,
    required this.iban,
    required this.relation,
    required this.phoneNumber,
    required this.accountHolderName,
    required this.bankName,
    required this.account,
  });

  @override
  // ignore: library_private_types_in_public_api
  _BankAccountTileState createState() => _BankAccountTileState();
}

class _BankAccountTileState extends State<BankAccountTile> {
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.account['favorite'] == 1;
  }

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        // Sync _isFavorite state with provider
        _isFavorite = provider.bankAccounts.firstWhere(
              (account) => account['id'] == widget.account['id'],
              orElse: () => {'favorite': 0},
            )['favorite'] ==
            1;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: Container(
                width: MySize.size48, // Adjust width for the square
                height: MySize.size48, // Adjust height for the square
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F5F9), // Background color
                  borderRadius: BorderRadius.circular(
                      8.0), // Rounded corners (set to 0 for no rounding)
                ),
                child: Icon(
                  Icons.account_balance, // Replace with your icon/image
                  size: MySize.size30,
                ),
              ),
              title: Text(
                widget.accountHolderName,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: MySize.size16,
                ),
              ),
              subtitle: Text(
                widget.category,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w400,
                  fontSize: MySize.size14,
                  color: Colors.grey[600],
                ),
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.star,
                  color: _isFavorite ? Colors.amber : Colors.grey,
                  size: MySize.size28,
                ),
                onPressed: () {
                  setState(() {
                    _isFavorite = !_isFavorite;
                  });
                  provider.toggleFavorite(widget.account['id'], _isFavorite);
                },
              ),
              onTap: () {
                // Toggle additional details or navigation
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => DetailInformationBottomsheet(
                    account: widget.account,
                    onDelete: () async {
                      final provider =
                          Provider.of<DatabaseProvider>(context, listen: false);
                      await provider.deleteBankAccount(
                          widget.account['id']); // Pass the ID to delete
                    },
                  ),
                );
              },
            ),
            const Divider(
              thickness: 1.0, // Adjust thickness of the line
              color: Colors.grey, // Adjust color of the divider
              indent: 16.0, // Optional: space from left
              endIndent: 16.0, // Optional: space from right
            ),
          ],
        );
      },
    );
  }

  Future<void> openBrowser(String url, BuildContext context) async {
    final Uri uri = Uri.parse(url);

    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to open browser. Error: $e')),
      );
    }
  }
}
