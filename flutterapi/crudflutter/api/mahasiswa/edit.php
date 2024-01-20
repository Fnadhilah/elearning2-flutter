<?php
$conn = mysqli_connect("localhost","root","","crudflutter1");
$id = $_POST["id"];
$npm = $_POST["npm"];
$nama = $_POST["nama"];
$alamat = $_POST["alamat"];
$data = mysqli_query($conn, "update mahasiswa set npm='$npm', nama='$nama', alamat='$alamat' where id='$id'");

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