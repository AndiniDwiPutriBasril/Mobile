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
            $stmt = $pdo->prepare("SELECT * FROM buku WHERE id = ?");
            $stmt->execute([$id]);
            $buku = $stmt->fetch(PDO::FETCH_ASSOC);

            if ($buku){
                echo json_encode($buku);
            } else {
                http_response_code(404);
                echo json_encode(["message" => "Buku Tidak Ditemukan"]);
            }
        }else {
            $stmt = $pdo->query("SELECT * FROM buku");
            $buku = $stmt->fetchAll(PDO::FETCH_ASSOC);
            echo json_encode($buku);
        }
        break;

    case 'POST':
        $data = json_decode(file_get_contents("php://input"), true);

        if (!empty($data['kode_buku']) && !empty($data['judul']) && !empty($data['pengarang']) && 
            !empty($data['penerbit']) && !empty($data['tahun_terbit'])) {
            $stmt = $pdo->prepare("INSERT INTO buku (kode_buku, judul, pengarang, penerbit, tahun_terbit) 
                                  VALUES (?, ?, ?, ?, ?)");
            $stmt->execute([
                $data['kode_buku'],
                $data['judul'],
                $data['pengarang'],
                $data['penerbit'],
                $data['tahun_terbit']
            ]);
            echo json_encode(["message" => "Buku berhasil ditambahkan", "id" => $pdo->lastInsertId()]);
        } else {
            http_response_code(400);
            echo json_encode(["message" => "Data tidak valid"]);
        }
        break;

    case 'PUT':
        if ($id) {
            $data = json_decode(file_get_contents("php://input"), true);

            $stmt = $pdo->prepare("SELECT * FROM buku WHERE id = ?");
            $stmt->execute([$id]);
            $buku = $stmt->fetch(PDO::FETCH_ASSOC);

            if ($buku) {
                $kode_buku = $data['kode_buku'] ?? $buku['kode_buku'];
                $judul = $data['judul'] ?? $buku['judul'];
                $pengarang = $data['pengarang'] ?? $buku['pengarang'];
                $penerbit = $data['penerbit'] ?? $buku['penerbit'];
                $tahun_terbit = $data['tahun_terbit'] ?? $buku['tahun_terbit'];

                $stmt = $pdo->prepare("UPDATE buku SET kode_buku = ?, judul = ?, pengarang = ?, 
                                     penerbit = ?, tahun_terbit = ? WHERE id = ?");
                $stmt->execute([$kode_buku, $judul, $pengarang, $penerbit, $tahun_terbit, $id]);
                echo json_encode(["message" => "Buku berhasil diperbarui"]);
            }else {
                http_response_code(404);
                echo json_encode(["message" => "Buku tidak ditemukan"]);
            }
        }else {
            http_response_code(400);
            echo json_encode(["message" => "ID tidak diberikan"]);
        }
        break;

    case 'DELETE':
        if ($id) {
            $stmt = $pdo->prepare("SELECT * FROM buku WHERE id = ?");
            $stmt->execute([$id]);
            $buku = $stmt->fetch(PDO::FETCH_ASSOC);

            if($buku){
                $stmt = $pdo->prepare("DELETE FROM buku WHERE id = ?");
                $stmt->execute([$id]);
                echo json_encode(["message" => "Buku berhasil dihapus"]);
            } else {
                http_response_code(404);
                echo json_encode(["message" => "Buku tidak ditemukan"]);
            }
        }else {
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
