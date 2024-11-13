<?php
require 'config.php';

header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE");
header("Access-Control-Allow-Headers: Content-Type");

$method = $_SERVER['REQUEST_METHOD'];
$Path_Info = isset($_SERVER['PATH_INFO']) ? $_SERVER['PATH_INFO'] : (isset($_SERVER['ORIG_PATH_INFO']) ? $_SERVER['ORIG_PATH_INFO'] : '');
$request = explode('/', trim($Path_Info, '/'));

$id = isset($request[1]) ? (int)$request[1] : null;

switch($method){
    case 'GET':
        if($id) {
            $stmt = $pdo->prepare("
                SELECT pg.id, pg.tanggal_dikembalikan, pg.terlambat, pg.denda,
                       p.tanggal_pinjam, p.tanggal_kembali,
                       a.nama as nama_anggota, b.judul as judul_buku
                FROM pengembalian pg
                JOIN peminjaman p ON pg.peminjaman = p.id
                JOIN anggota a ON p.anggota = a.id
                JOIN buku b ON p.buku = b.id
                WHERE pg.id = ?
            ");
            $stmt->execute([$id]);
            $pengembalian = $stmt->fetch(PDO::FETCH_ASSOC);

            if ($pengembalian){
                echo json_encode($pengembalian);
            } else {
                http_response_code(404);
                echo json_encode(["message" => "Pengembalian tidak ditemukan"]);
            }
        } else {
            $stmt = $pdo->query("
                SELECT pg.id, pg.tanggal_dikembalikan, pg.terlambat, pg.denda,
                       p.tanggal_pinjam, p.tanggal_kembali,
                       a.nama as nama_anggota, b.judul as judul_buku
                FROM pengembalian pg
                JOIN peminjaman p ON pg.peminjaman = p.id
                JOIN anggota a ON p.anggota = a.id
                JOIN buku b ON p.buku = b.id
            ");
            $pengembalian = $stmt->fetchAll(PDO::FETCH_ASSOC);
            echo json_encode($pengembalian);
        }
        break;

    case 'POST':
        $data = json_decode(file_get_contents("php://input"), true);
        
        if (!isset($data)) {
            http_response_code(400);
            echo json_encode(["message" => "Data JSON tidak valid"]);
            break;
        }

        if (!empty($data['tanggal_dikembalikan']) && 
            isset($data['terlambat']) && 
            isset($data['denda']) && 
            !empty($data['peminjaman'])) {
            
            try {
                $stmt = $pdo->prepare("INSERT INTO pengembalian 
                    (tanggal_dikembalikan, terlambat, denda, peminjaman) 
                    VALUES (?, ?, ?, ?)");
                $stmt->execute([
                    $data['tanggal_dikembalikan'],
                    $data['terlambat'],
                    $data['denda'],
                    $data['peminjaman']
                ]);
                echo json_encode([
                    "message" => "Pengembalian berhasil ditambahkan", 
                    "id" => $pdo->lastInsertId()
                ]);
            } catch (PDOException $e) {
                http_response_code(500);
                echo json_encode(["message" => "Error: " . $e->getMessage()]);
            }
        } else {
            http_response_code(400);
            echo json_encode(["message" => "Data tidak lengkap"]);
        }
        break;

    case 'PUT':
        if ($id) {
            $data = json_decode(file_get_contents("php://input"), true);

            $stmt = $pdo->prepare("SELECT * FROM pengembalian WHERE id = ?");
            $stmt->execute([$id]);
            $pengembalian = $stmt->fetch(PDO::FETCH_ASSOC);

            if ($pengembalian) {
                $tanggal_dikembalikan = $data['tanggal_dikembalikan'] ?? $pengembalian['tanggal_dikembalikan'];
                $terlambat = $data['terlambat'] ?? $pengembalian['terlambat'];
                $denda = $data['denda'] ?? $pengembalian['denda'];
                $id_peminjaman = $data['id_peminjaman'] ?? $pengembalian['id_peminjaman'];

                $stmt = $pdo->prepare("UPDATE pengembalian SET tanggal_dikembalikan = ?, terlambat = ?, 
                                     denda = ?, id_peminjaman = ? WHERE id = ?");
                $stmt->execute([$tanggal_dikembalikan, $terlambat, $denda, $id_peminjaman, $id]);
                echo json_encode(["message" => "Data pengembalian berhasil diperbarui"]);
            } else {
                http_response_code(404);
                echo json_encode(["message" => "Pengembalian tidak ditemukan"]);
            }
        } else {
            http_response_code(400);
            echo json_encode(["message" => "ID tidak diberikan"]);
        }
        break;

    case 'DELETE':
        if ($id) {
            $stmt = $pdo->prepare("SELECT * FROM pengembalian WHERE id = ?");
            $stmt->execute([$id]);
            $pengembalian = $stmt->fetch(PDO::FETCH_ASSOC);

            if($pengembalian){
                $stmt = $pdo->prepare("DELETE FROM pengembalian WHERE id = ?");
                $stmt->execute([$id]);
                echo json_encode(["message" => "Pengembalian berhasil dihapus"]);
            } else {
                http_response_code(404);
                echo json_encode(["message" => "Pengembalian tidak ditemukan"]);
            }
        } else {
            http_response_code(400);
            echo json_encode(["message" => "ID tidak diberikan"]);
        }
        break;

    default:
        http_response_code(405);
        echo json_encode(["message" => "Metode tidak diizinkan"]);
        break;
}
?> 