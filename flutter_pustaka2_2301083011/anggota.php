<?php
require 'config.php';

//set header agar API bisa diakses dari luar
header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE");
header("Access-Control-Allow-Headers: Content-Type");

$method = $_SERVER['REQUEST_METHOD'];
$Path_Info = isset($_SERVER['PATH_INFO']) ? $_SERVER['PATH_INFO'] : (isset($_SERVER['ORIG_PATH_INFO']) ? $_SERVER['ORIG_PATH_INFO'] : '');
$request = explode('/', trim($Path_Info, '/'));

//Ambil ID jika ada 
$id = isset($request[1]) ? (int)$request[1] : null;

switch($method){
    case 'GET':
        if($id) {
            $stmt = $pdo->prepare("SELECT * FROM anggota WHERE id = ?");
            $stmt->execute([$id]);
            $anggota = $stmt->fetch(PDO::FETCH_ASSOC);

            if ($anggota){
                echo json_encode($anggota);
            } else {
                http_response_code(404);
                echo json_encode(["message" => "Anggota Tidak Ditemukan"]);
            }
        }else {
            $stmt = $pdo->query("SELECT * FROM anggota");
            $anggota = $stmt->fetchAll(PDO::FETCH_ASSOC);
            echo json_encode($anggota);
        }
        break;

    case 'POST':
        $data = json_decode(file_get_contents("php://input"), true);

        if (!empty($data['kode_anggota']) && !empty($data['nama']) && !empty($data['alamat']) && 
            !empty($data['jenis_kelamin'])) {
            $stmt = $pdo->prepare("INSERT INTO anggota (kode_anggota, nama, alamat, jenis_kelamin) 
                                  VALUES (?, ?, ?, ?)");
            $stmt->execute([
                $data['kode_anggota'],
                $data['nama'],
                $data['alamat'],
                $data['jenis_kelamin']
            ]);
            echo json_encode(["message" => "Anggota berhasil ditambahkan", "id" => $pdo->lastInsertId()]);
        } else {
            http_response_code(400);
            echo json_encode(["message" => "Data tidak valid"]);
        }
        break;

    case 'PUT':
        if ($id) {
            $data = json_decode(file_get_contents("php://input"), true);

            $stmt = $pdo->prepare("SELECT * FROM anggota WHERE id = ?");
            $stmt->execute([$id]);
            $anggota = $stmt->fetch(PDO::FETCH_ASSOC);

            if ($anggota) {
                $kode_anggota = $data['kode_anggota'] ?? $anggota['kode_anggota'];
                $nama = $data['nama'] ?? $anggota['nama'];
                $alamat = $data['alamat'] ?? $anggota['alamat'];
                $jenis_kelamin = $data['jenis_kelamin'] ?? $anggota['jenis_kelamin'];

                $stmt = $pdo->prepare("UPDATE anggota SET kode_anggota = ?, nama = ?, alamat = ?, 
                                     jenis_kelamin = ? WHERE id = ?");
                $stmt->execute([$kode_anggota, $nama, $alamat, $jenis_kelamin, $id]);
                echo json_encode(["message" => "Anggota berhasil diperbarui"]);
            }else {
                http_response_code(404);
                echo json_encode(["message" => "Anggota tidak ditemukan"]);
            }
        }else {
            http_response_code(400);
            echo json_encode(["message" => "ID tidak diberikan"]);
        }
        break;

    // ... case DELETE sama seperti sebelumnya, hanya ganti 'buku' menjadi 'anggota' ...
}
?>
