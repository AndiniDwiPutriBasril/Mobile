<?php
require 'config.php';

header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

// Handle preflight request
if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {
    http_response_code(200);
    exit();
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Baca data JSON yang dikirim
    $data = json_decode(file_get_contents('php://input'), true);
    
    // Validasi data yang diterima
    if (!isset($data['tanggal_pinjam']) || !isset($data['tanggal_kembali']) || 
        !isset($data['anggota_id']) || !isset($data['buku_id'])) {
        http_response_code(400);
        echo json_encode(["message" => "Data tidak lengkap"]);
        exit;
    }
    
    try {
        // Cek ketersediaan buku
        $stmt = $pdo->prepare("SELECT * FROM buku WHERE id = ? AND status = 'tersedia'");
        $stmt->execute([$data['buku_id']]);
        $buku = $stmt->fetch();
        
        if (!$buku) {
            http_response_code(400);
            echo json_encode(["message" => "Buku tidak tersedia"]);
            exit;
        }
        
        // Cek validitas anggota
        $stmt = $pdo->prepare("SELECT * FROM anggota WHERE id = ?");
        $stmt->execute([$data['anggota_id']]);
        $anggota = $stmt->fetch();
        
        if (!$anggota) {
            http_response_code(400);
            echo json_encode(["message" => "Anggota tidak ditemukan"]);
            exit;
        }
        
        // Mulai transaksi
        $pdo->beginTransaction();
        
        // Insert peminjaman
        $stmt = $pdo->prepare("INSERT INTO peminjaman (tanggal_pinjam, tanggal_kembali, anggota_id, buku_id) 
                              VALUES (?, ?, ?, ?)");
        $stmt->execute([
            $data['tanggal_pinjam'],
            $data['tanggal_kembali'],
            $data['anggota_id'],
            $data['buku_id']
        ]);
        
        // Update status buku
        $stmt = $pdo->prepare("UPDATE buku SET status = 'dipinjam' WHERE id = ?");
        $stmt->execute([$data['buku_id']]);
        
        $pdo->commit();
        
        echo json_encode([
            "message" => "Peminjaman berhasil ditambahkan",
            "id" => $pdo->lastInsertId()
        ]);
        
    } catch (PDOException $e) {
        if ($pdo->inTransaction()) {
            $pdo->rollBack();
        }
        http_response_code(500);
        echo json_encode([
            "message" => "Gagal menambahkan peminjaman",
            "error" => $e->getMessage()
        ]);
    }
} else if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    try {
        $stmt = $pdo->query("SELECT * FROM peminjaman");
        $peminjaman = $stmt->fetchAll(PDO::FETCH_ASSOC);
        echo json_encode($peminjaman);
    } catch (PDOException $e) {
        http_response_code(500);
        echo json_encode([
            "message" => "Gagal mengambil data peminjaman",
            "error" => $e->getMessage()
        ]);
    }
} else {
    http_response_code(405);
    echo json_encode(["message" => "Metode tidak diizinkan"]);
}
?>