import 'package:account_saver/core/constants/app_all_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:provider/provider.dart';
import 'package:account_saver/database/database_provider.dart';
import 'package:account_saver/ui/widgets/bank_account_tile.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Consumer<DatabaseProvider>(
          builder: (context, provider, child) {
            return Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios,
                            color: Colors.blueGrey),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(color: Colors.blueGrey),
                          ),
                          child: TextField(
                            onChanged: (query) {
                              provider.searchAccounts(query);
                            },
                            decoration:  InputDecoration(
                              labelText: AppLocale.search.getString(context),
                              border: InputBorder.none,
                              prefixIcon:
                                  const Icon(Icons.search, color: Colors.blueGrey),
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: provider.filteredAccounts.length,
                    itemBuilder: (context, index) {
                      final account = provider.filteredAccounts[index];
                      return BankAccountTile(
                        accountNumber: account['account_number'],
                        category: account['category'],
                        iban: account['iban'],
                        relation: account['relation'],
                        phoneNumber: account['phone_number'],
                        // onDelete: () async {
                        //   final provider = Provider.of<DatabaseProvider>(
                        //       context,
                        //       listen: false);
                        //   await provider.deleteBankAccount(
                        //       account['id']); // Pass the ID to delete
                        // },
                        accountHolderName:
                            account["account_holder_name"] ?? "n/a",
                        bankName: account["bank_name"] ?? "n/a",
                        account: account,
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
