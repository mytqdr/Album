<?php
session_start();
session_unset();
session_destroy();
echo "<script> alert('注销成功！'); </script>"; 
echo "<meta http-equiv='Refresh' content='0;URL=index.php'>"; 
?>