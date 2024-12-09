<?php
require 'config.php';

header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Accept, Authorization");

// Handle preflight request
if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {
    http_response_code(200);
    exit();
}

try {
    if ($_SERVER['REQUEST_METHOD'] === 'GET') {
        $stmt = $pdo->query("SELECT * FROM pengembalian");
        $pengembalian = $stmt->fetchAll(PDO::FETCH_ASSOC);
        echo json_encode($pengembalian);
    } 
    else if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        $data = json_decode(file_get_contents("php://input"), true);
        
        $stmt = $pdo->prepare("INSERT INTO pengembalian (tanggal_pengembalian, denda, terlambat, peminjaman_id) VALUES (?, ?, ?, ?)");
        $stmt->execute([
            $data['tanggal_pengembalian'],
            $data['denda'],
            $data['terlambat'],
            $data['peminjaman_id']
        ]);
        
        echo json_encode([
            "message" => "Success",
            "id" => $pdo->lastInsertId()
        ]);
    }
} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(["error" => $e->getMessage()]);
}
?>