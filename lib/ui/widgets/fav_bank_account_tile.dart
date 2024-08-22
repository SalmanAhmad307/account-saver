import 'package:account_saver/database/database_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavBankAccountTile extends StatefulWidget {
  final String accountNumber;
  final String category;
  final String iban;
  final String relation;
  final String phoneNumber;
  final String accountHolderName;
  final String bankName;
  final Map<String, dynamic> account;
  final void Function() onShare;
  final void Function() onDelete;

  const FavBankAccountTile({
    super.key,
    required this.accountNumber,
    required this.category,
    required this.iban,
    required this.relation,
    required this.phoneNumber,
    required this.accountHolderName,
    required this.bankName,
    required this.account,
    required this.onShare,
    required this.onDelete,
  });

  @override
  // ignore: library_private_types_in_public_api
  _BankAccountTileState createState() => _BankAccountTileState();
}

class _BankAccountTileState extends State<FavBankAccountTile> {
  bool _isFavorite = false;
  bool _isExpanded = false;
  late int fav;

  @override
  void initState() {
    super.initState();
    _loadFavoriteStatus();
  }

  Future<void> _loadFavoriteStatus() async {
    final provider = Provider.of<DatabaseProvider>(context, listen: false);
    final account = provider.bankAccounts
        .firstWhere((acc) => acc['id'] == widget.account['id']);
    setState(() {
      fav = account['favorite'];
      _isFavorite = account['favorite'] == 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      elevation: 4.0,
      child: ExpansionTile(
        title: Text(
          "${widget.accountHolderName} | ${widget.accountNumber} | ${widget.category}",
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(
                Icons.star,
                color: _isFavorite ? Colors.amber : Colors.black,
              ),
              onPressed: () {
                setState(() {
                  _isFavorite = !_isFavorite;
                });
                final provider =
                    Provider.of<DatabaseProvider>(context, listen: false);
                provider.toggleFavorite(widget.account['id'], _isFavorite);
              },
            ),
            Icon(_isExpanded ? Icons.expand_less : Icons.expand_more),
          ],
        ),
        onExpansionChanged: (expanded) {
          setState(() {
            _isExpanded = expanded;
          });
        },
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Account Holder: ${widget.accountHolderName}'),
                Text('Bank Name: ${widget.bankName}'),
                Text('Category: ${widget.category}'),
                Text('IBAN: ${widget.iban}'),
                Text('Relation: ${widget.relation}'),
                Text('Phone Number: ${widget.phoneNumber}'),
              ],
            ),
          ),
          OverflowBar(
            alignment: MainAxisAlignment.start,
            children: [
              IconButton(
                icon: const Icon(Icons.share),
                onPressed: widget.onShare,
                tooltip: 'Share',
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () async {
                  final provider =
                      Provider.of<DatabaseProvider>(context, listen: false);
                  await provider.deleteBankAccount(widget.account['id']);
                  widget.onDelete(); // Trigger any additional delete actions
                },
                tooltip: 'Delete',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
