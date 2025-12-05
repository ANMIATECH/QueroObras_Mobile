import '../const/export.dart';

// class StorageDesign {
//   static final _storage = GetStorage();
//
//   // Create
//   static void createItem(String key, dynamic value) {
//     _storage.write(key, value);
//   }
//
//   // Read
//   static dynamic readItem(String key) {
//     return _storage.read(key);
//   }
//
//   // Update
//   static void updateItem(String key, dynamic newValue) {
//     _storage.write(key, newValue);
//   }
//
//   // Delete
//   static void deleteItem(String key) {
//     _storage.remove(key);
//   }
//
//   static bool validKey(String key) {
//     return _storage.hasData(key);
//   }
//
//   static String token = "token";
//   static String userType = "userType";
//   static String firstTimerUser = "firstTimerUser";
//
//   static String? validation(dynamic value, String object) {
//     if (value == null || value.isEmpty) {
//       return 'Please enter $object';
//     }
//     return null;
//   }
// }

class StorageDesign {
  static final _storage = GetStorage();

  // Create
  static void createItem(String key, dynamic value) {
    _storage.write(key, value);
  }

  // Read
  static dynamic readItem(String key) {
    return _storage.read(key);
  }

  // Update
  static void updateItem(String key, dynamic newValue) {
    _storage.write(key, newValue);
  }

  // Delete
  static void deleteItem(String key) {
    _storage.remove(key);
  }

  static bool validKey(String key) {
    return _storage.hasData(key);
  }

  // Keys
  static String token = "token";
  static String userType = "userType";
  static String firstTimerUser = "firstTimerUser";
  static String tokenExpiry = "tokenExpiry"; // <-- Add expiry key

  // Check token validity
  static bool isTokenValid() {
    String? expiryStr = readItem(tokenExpiry);
    if (expiryStr != null) {
      DateTime expiry = DateTime.parse(expiryStr);
      if (DateTime.now().isAfter(expiry)) {
        // Token expired
        deleteItem(token);
        deleteItem(userType);
        deleteItem(tokenExpiry);
        return false;
      }
    }
    return readItem(token) != null;
  }

  static String? validation(dynamic value, String object) {
    if (value == null || value.isEmpty) {
      return 'Please enter $object';
    }
    return null;
  }
}

