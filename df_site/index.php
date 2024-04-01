<?php
$user = "db_user";
$password = "password";
$database = "db502";
$table = "mytab";

try {
  $db = new PDO("mysql:host=127.0.0.1;dbname=$database", $user, $password);
  echo "<h2>MA DB</h2><ol>";
  foreach($db->query("SELECT content FROM $table") as $row) {
    echo "<li>" . $row['content'] . "</li>";
  }
  echo "</ol>";
} catch (PDOExecption $e) {
    print "Error!: " . $e->getMessage() . "<br/>";
    die();
}
