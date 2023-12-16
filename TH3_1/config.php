<?php
class config {
    const HOST = 'localhost';
    const DB_NAME = 'your_database_name';
    const USERNAME = 'your_database_username';
    const PASSWORD = 'your_database_password';
    public static function getConnection() {
try {
    $dsn = 'mysql:host=' . self::HOST . ';dbname=' .
self::DB_NAME;
    $connection = new PDO($dsn, self::USERNAME,
self::PASSWORD);
    $connection->setAttribute(PDO::ATTR_ERRMODE,
PDO::ERRMODE_EXCEPTION);
    return $connection;
    } catch (PDOException $e) {
    echo "Kết nối cơ sở dữ liệu thất bại: " . $e->getMessage();
    exit;
        }
    }
}
