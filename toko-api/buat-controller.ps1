
$d = "app\Controllers"
New-Item -ItemType Directory -Force -Path $d | Out-Null

$registrasi = @'
<?php

namespace App\Controllers;

use App\Models\MemberModel;

class RegistrasiController extends RestfulController
{
    public function registrasi()
    {
        $input = $this->request->getJSON(true) ?? [];

        $nama = $input['nama'] ?? '';
        $email = $input['email'] ?? '';
        $password = $input['password'] ?? '';

        if ($nama === '' || $email === '' || $password === '') {
            return $this->responseHasil(400, false, 'Semua data harus diisi');
        }

        $model = new MemberModel();

        if ($model->where('email', $email)->first()) {
            return $this->responseHasil(400, false, 'Email sudah terdaftar');
        }

        $data = [
            'nama' => $nama,
            'email' => $email,
            'password' => password_hash($password, PASSWORD_DEFAULT)
        ];

        $model->insert($data);

        return $this->responseHasil(200, true, 'Registrasi Berhasil');
    }
}
'@

$login = @'
<?php

namespace App\Controllers;

use App\Models\MemberModel;
use App\Models\MemberTokenModel;

class LoginController extends RestfulController
{
    public function login()
    {
        $input = $this->request->getJSON(true) ?? [];

        $email = $input['email'] ?? '';
        $password = $input['password'] ?? '';

        $model = new MemberModel();
        $member = $model->where('email', $email)->first();

        if (!$member) {
            return $this->responseHasil(400, false, 'Email tidak ditemukan');
        }

        if (!password_verify($password, $member['password'])) {
            return $this->responseHasil(400, false, 'Password tidak valid');
        }

        $authKey = bin2hex(random_bytes(50));

        $login = new MemberTokenModel();
        $login->insert([
            'member_id' => $member['id'],
            'auth_key' => $authKey
        ]);

        $data = [
            'token' => $authKey,
            'user' => [
                'id' => $member['id'],
                'email' => $member['email']
            ]
        ];

        return $this->responseHasil(200, true, $data);
    }
}
'@

$produk = @'
<?php

namespace App\Controllers;

use App\Models\ProdukModel;

class ProdukController extends RestfulController
{
    public function create()
    {
        $input = $this->request->getJSON(true) ?? [];

        $data = [
            'kode_produk' => $input['kode_produk'] ?? '',
            'nama_produk' => $input['nama_produk'] ?? '',
            'harga' => $input['harga'] ?? 0
        ];

        if ($data['kode_produk'] === '' || $data['nama_produk'] === '' || !is_numeric($data['harga'])) {
            return $this->responseHasil(400, false, 'Data produk tidak valid');
        }

        $model = new ProdukModel();
        $model->insert($data);
        $produk = $model->find($model->getInsertID());

        return $this->responseHasil(200, true, $produk);
    }

    public function list()
    {
        $model = new ProdukModel();
        $produk = $model->findAll();

        return $this->responseHasil(200, true, $produk);
    }

    public function detail($id)
    {
        $model = new ProdukModel();
        $produk = $model->find($id);

        if (!$produk) {
            return $this->responseHasil(404, false, 'Produk tidak ditemukan');
        }

        return $this->responseHasil(200, true, $produk);
    }

    public function ubah($id)
    {
        $model = new ProdukModel();
        $produk = $model->find($id);

        if (!$produk) {
            return $this->responseHasil(404, false, 'Produk tidak ditemukan');
        }

        $input = $this->request->getJSON(true) ?? [];

        $data = [
            'kode_produk' => $input['kode_produk'] ?? '',
            'nama_produk' => $input['nama_produk'] ?? '',
            'harga' => $input['harga'] ?? 0
        ];

        if ($data['kode_produk'] === '' || $data['nama_produk'] === '' || !is_numeric($data['harga'])) {
            return $this->responseHasil(400, false, 'Data produk tidak valid');
        }

        $model->update($id, $data);
        $produk = $model->find($id);

        return $this->responseHasil(200, true, $produk);
    }

    public function hapus($id)
    {
        $model = new ProdukModel();
        $produk = $model->find($id);

        if (!$produk) {
            return $this->responseHasil(404, false, 'Produk tidak ditemukan');
        }

        $model->delete($id);

        return $this->responseHasil(200, true, true);
    }
}
'@

$utf8 = New-Object System.Text.UTF8Encoding($false)

[IO.File]::WriteAllText("$d\RegistrasiController.php", $registrasi, $utf8)
[IO.File]::WriteAllText("$d\LoginController.php", $login, $utf8)
[IO.File]::WriteAllText("$d\ProdukController.php", $produk, $utf8)

Write-Host "BERHASIL: 3 Controller berhasil dibuat."
