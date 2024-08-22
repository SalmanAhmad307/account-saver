import 'package:flutter/foundation.dart';
import 'database_helper.dart';

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<Map<String, dynamic>> _bankAccounts = [];
  List<Map<String, dynamic>> _favoriteAccounts = [];

  List<Map<String, dynamic>> get bankAccounts => _bankAccounts;
  List<Map<String, dynamic>> get favoriteAccounts => _favoriteAccounts;

  DatabaseProvider() {
    _initializeDatabase();
  }

  Future<void> _initializeDatabase() async {
    await _dbHelper.database;
    fetchBankAccounts();
  }

  Future<void> fetchBankAccounts() async {
    _bankAccounts = await _dbHelper.queryAllBankAccounts();
    notifyListeners();
  }

  Future<void> addBankAccount(Map<String, dynamic> account) async {
    await _dbHelper.insertBankAccount(account);
    fetchBankAccounts();
  }

  Future<void> deleteBankAccount(int id) async {
    await _dbHelper.deleteBankAccount(id);
    fetchBankAccounts();
    await fetchFavoriteAccounts(); // Ensure favorites are updated
  }

  Future<void> toggleFavorite(int id, bool isFavorite) async {
    await _dbHelper.updateFavoriteStatus(id, isFavorite);
    await fetchBankAccounts(); // Update the bank accounts list
    await fetchFavoriteAccounts(); // Update the favorite accounts list
    notifyListeners();
  }

  Future<List<Map<String, dynamic>>> fetchFavoriteAccounts() async {
    
    _favoriteAccounts = await _dbHelper.queryFavoriteAccounts();
    notifyListeners();
    return _favoriteAccounts;
  }
}
