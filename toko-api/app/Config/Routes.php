
<?php

use CodeIgniter\Router\RouteCollection;

/**
 * @var RouteCollection $routes
 */

$routes->get('/', 'Home::index');

// Route Registrasi
$routes->post('registrasi', 'RegistrasiController::registrasi');

// Route Login
$routes->post('login', 'LoginController::login');

// Route CRUD Produk
$routes->group('produk', function ($routes) {
    // Menambahkan produk
    $routes->post('/', 'ProdukController::create');

    // Menampilkan semua produk
    $routes->get('/', 'ProdukController::list');

    // Menampilkan detail produk berdasarkan ID
    $routes->get('(:segment)', 'ProdukController::detail/$1');

    // Mengubah produk berdasarkan ID
    $routes->put('(:segment)', 'ProdukController::ubah/$1');

    // Menghapus produk berdasarkan ID
    $routes->delete('(:segment)', 'ProdukController::hapus/$1');
});
