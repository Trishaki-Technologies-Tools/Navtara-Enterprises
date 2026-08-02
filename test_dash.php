<?php
session_start();
$_SESSION['user_id'] = 1;
$_SESSION['role_name'] = 'Owner';
require_once 'api/dashboard.php';
