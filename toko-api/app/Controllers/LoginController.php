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