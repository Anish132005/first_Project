import 'package:mysql1/mysql1.dart';

class Mysql {
  static String host = 'localhost',
      user = 'root',
      password = '1234',
      db = 'company';  // Ensure this matches your database name
  static int port = 3306;

  Mysql();

  Future<MySqlConnection> getConnection() async {
    var settings = new ConnectionSettings(
      host: host,
      port: port,
      user: user,
      password: password,
      db: db,
    );
    return await MySqlConnection.connect(settings);
  }

  Future<void> createTable() async {
    var conn = await getConnection();
    await conn.query('''
    CREATE TABLE IF NOT EXISTS employees (
      id INT AUTO_INCREMENT PRIMARY KEY,
      name VARCHAR(100),
      position VARCHAR(50),
      salary DECIMAL(10, 2)
    )
    ''');
    await conn.close();
  }

  Future<void> testConnection() async {
    var conn = await getConnection();
    var result = await conn.query('SELECT 1');  // Test query
    print(result);
    await conn.close();
  }
}

void main() async {
  Mysql db = new Mysql();
  await db.testConnection();  // Test the connection
  await db.createTable();  // Create the table if it doesn't exist
}
