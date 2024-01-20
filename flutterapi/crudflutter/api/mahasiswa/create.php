<?php
$conn = mysqli_connect("localhost","root","","crudflutter1");
$npm = $_POST["npm"];
$nama = $_POST["nama"];
$alamat = $_POST["alamat"];
$data = mysqli_query($conn, "insert into mahasiswa set npm='$npm', nama='$nama', alamat='$alamat'");

if ($data) {
    echo json_encode([
        'pesan' => 'Success'
    ]);
} else {
    echo json_encode([
        'pesan' => 'Failed'
    ]);
}


?>