import 'package:account_saver/ui/widgets/bank_account_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../database/database_provider.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late Future<void> _fetchData;

  @override
  void initState() {
    super.initState();
    _fetchData = _loadData();
  }

  Future<void> _loadData() async {
    final provider = Provider.of<DatabaseProvider>(context, listen: false);
    await provider.fetchFavoriteAccounts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: Consumer<DatabaseProvider>(
        builder: (context, provider, child) {
          return FutureBuilder<void>(
            future: _fetchData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (provider.favoriteAccounts.isEmpty) {
                return const Center(child: Text('No favorite accounts.'));
              } else {
                return ListView.builder(
                  itemCount: provider.favoriteAccounts.length,
                  itemBuilder: (context, index) {
                    final account = provider.favoriteAccounts[index];
                    return BankAccountTile(
                      accountNumber: account['account_number'],
                      category: account['category'],
                      iban: account['iban'],
                      relation: account['relation'],
                      phoneNumber: account['phone_number'],
                      onDelete: () async {
                        final provider = Provider.of<DatabaseProvider>(context,
                            listen: false);
                        await provider.deleteBankAccount(
                            account['id']); // Pass the ID to delete
                        await provider
                            .fetchFavoriteAccounts(); // Refresh the favorite accounts
                      },
                      accountHolderName:
                          account['account_holder_name'] ?? "n/a",
                      bankName: account['bank_name'] ?? "n/a",
                      account: account,
                    );
                  },
                );
              }
            },
          );
        },
      ),
    );
  }
}
