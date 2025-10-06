<?php
// Vercel PHP entry: forward all requests to Laravel's front controller
chdir(__DIR__ . '/../');
require __DIR__ . '/../public/index.php';
