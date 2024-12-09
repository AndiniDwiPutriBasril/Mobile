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
    case 'GET' :
        if($id) {
            //Get student by id
            $stmt = $pdo->prepare("SELECT * FROM anggota WHERE id = ?");
            $stmt->execute([$id]);
            $student = $stmt->fetch(PDO:: FETCH_ASSOC);

            if ($student){
                echo json_encode($student);
            } else {
                http_response_code(404);
                echo json_encode(["message" => "Student Not Found"]);
            }
        }else {
            //GET ALL STUDENTS
            $stmt = $pdo->query("SELECT * FROM anggota");
            $anggota = $stmt->fetchAll(PDO::FETCH_ASSOC);
            echo json_encode($anggota);
        }
        break;

    case 'POST' :
        //create new anggota 
        $data = json_decode(file_get_contents("php://input"), true);

        if (!empty($data['nim']) && !empty($data['nama']) && !empty($data['alamat']) && 
            !empty($data['jenis_kelamin']) && in_array($data['jenis_kelamin'], ['L', 'P'])) {
            
            $stmt = $pdo->prepare("INSERT INTO anggota (nim, nama, alamat, jenis_kelamin) VALUES (?, ?, ?, ?)");
            $stmt->execute([$data['nim'], $data['nama'], $data['alamat'], $data['jenis_kelamin']]);
            echo json_encode(["message" => "Anggota created", "id" => $pdo->lastInsertId()]);
        
        } else {
            http_response_code(400);
            echo json_encode(["message" => "Invalid data. Jenis kelamin harus 'L' atau 'P'"]);
        }
        break;

    case 'PUT' :
        //update student by ID
        if ($id) {
            $data = json_decode(file_get_contents("php://input"), true);

            $stmt = $pdo->prepare("SELECT * FROM anggota WHERE id = ?");
            $stmt->execute([$id]);
            $anggota = $stmt->fetch(PDO::FETCH_ASSOC);

            if ($anggota) {
                $nim = $data['nim'] ?? $anggota['nim'];
                $nama = $data['nama'] ?? $anggota['nama'];
                $alamat = $data['alamat'] ?? $anggota['alamat'];
                $jenis_kelamin = $data['jenis_kelamin'] ?? $anggota['jenis_kelamin'];

                if (!in_array($jenis_kelamin, ['L', 'P'])) {
                    http_response_code(400);
                    echo json_encode(["message" => "Jenis kelamin harus 'L' atau 'P'"]);
                    exit;
                }

                $stmt = $pdo->prepare("UPDATE anggota SET nim = ?, nama = ?, alamat = ?, jenis_kelamin = ? WHERE id = ?");
                $stmt->execute([$nim, $nama, $alamat, $jenis_kelamin, $id]);
                echo json_encode(["message" => "Anggota update"]);
            }else {
                http_response_code(404);
                echo json_encode(["message" => "Anggota not found"]);
            }
        }else {
            http_response_code(400);
            echo json_encode(["message" => "ID not provided"]);
        }
        break;

    case 'DELETE' :
        //delete student by id
        if ($id) {
            $stmt = $pdo->prepare("SELECT * FROM anggota WHERE id = ?");
            $stmt->execute([$id]);
            $anggota = $stmt->fetch(PDO::FETCH_ASSOC);

            if($anggota){
                $stmt = $pdo->prepare("DELETE FROM anggota WHERE id = ?");
                $stmt->execute([$id]);
                echo json_encode(["message" => "Anggota delete"]);
            } else {
                http_response_code(404);
                echo json_encode(["message" => "Anggota not found"]);
            }
        }else {
            http_response_code(400);
            echo json_encode(["message" => "ID not provided"]);
        }
        break;

    default:
         http_response_code(405);
         echo json_encode(["message" => "Method not allowed"]);
        break;
}
?>