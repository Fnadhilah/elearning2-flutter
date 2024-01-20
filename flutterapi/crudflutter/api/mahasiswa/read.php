<?php
$conn = mysqli_connect("localhost","root","","crudflutter1");
$query = mysqli_query($conn, "select * from mahasiswa");
$data = mysqli_fetch_all($query, MYSQLI_ASSOC);
echo json_encode($data);



?>