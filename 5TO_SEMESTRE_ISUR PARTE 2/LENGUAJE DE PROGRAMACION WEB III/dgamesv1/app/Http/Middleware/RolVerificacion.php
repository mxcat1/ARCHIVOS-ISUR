<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class RolVerificacion
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle(Request $request, Closure $next)
    {

        if (Auth::check() && Auth::user()->roles=='Administrador') {
            return $next($request);
        }
        if (! Auth::check() ) {
            return redirect()->route('login');
        }
        abort(404);
    }
}
