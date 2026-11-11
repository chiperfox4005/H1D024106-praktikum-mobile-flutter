<?php
namespace App\Controllers;

use CodeIgniter\RESTful\ResourceController;

class RestfulController extends ResourceController
{
    protected $format = 'json';

    protected function responseHasil($code, $status, $data = null)
    {
        $response = [
            'code' => $code,
            'status' => $status,
            'data' => $data
        ];

        return $this->respond($response, $code);
    }
}