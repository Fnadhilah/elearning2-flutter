<?php
$conn = mysqli_connect("localhost","root","","crudflutter1");
$npm = $_POST["npm"];

$data = mysqli_query($conn, "delete from mahasiswa where npm='$npm'");

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