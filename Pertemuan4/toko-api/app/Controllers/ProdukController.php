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