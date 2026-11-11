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