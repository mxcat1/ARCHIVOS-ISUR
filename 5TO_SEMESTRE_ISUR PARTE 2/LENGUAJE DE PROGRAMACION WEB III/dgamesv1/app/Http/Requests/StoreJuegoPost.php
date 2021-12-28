<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class StoreJuegoPost extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            'nombreJuego' => 'required|min:1|max:255|unique:App\Models\Juego,nombreJuego',
            'descripcionJuego' => 'required|min:10',
            'fechalanzamientoJuego' => 'required',
            'desarrolladoraJuego' => 'required|min:5|max:255',
            'imagenJuego' => 'required|image',
            'estadoJuego' => 'required'
        ];
    }
}
