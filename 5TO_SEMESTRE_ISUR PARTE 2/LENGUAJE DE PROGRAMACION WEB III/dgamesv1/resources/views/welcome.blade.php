<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>DGAMES</title>

    <!-- Google Font: Source Sans Pro -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="{{asset('libs/fontawesome-free/css/all.min.css')}}">
    <!-- Ionicons -->
    <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
    <!-- Tempusdominus Bootstrap 4 -->

    <!-- Theme style -->
    <link rel="stylesheet" href="{{asset('css/adminlte.min.css')}}">
    <!-- overlayScrollbars -->
    <link rel="stylesheet" href="{{asset('libs/overlayScrollbars/css/OverlayScrollbars.min.css')}}">
    <link rel="shortcut icon" href="{{asset('img/logo.ico')}}" type="image/x-icon">


    <style>
        .fondo-inicio{
            background: url({{asset('img/fondo_inicio.png')}}) center;
            background-size: cover;
        }
    </style>
</head>
<body class="hold-transition lockscreen fondo-inicio">
<div class="relative flex items-top justify-center min-h-screen bg-gray-100 dark:bg-gray-900 sm:items-center py-4 sm:pt-0">

        <div class="lockscreen-wrapper">
            <div class="lockscreen-logo">
                <p class="display-2 text-light"><b>DGAMES</b>V1 API</p>
                <img class="img-fluid" src="{{asset('img/logo.png')}}" width="150px" alt="logo image">
            </div>

            <div class="text-center text-light">
                @if (Route::has('login'))
                    <div class="top-0 right-0 px-6 py-4 d-flex justify-content-around">
                        @auth

                            @if (Auth::user()->roles=='Administrador')
                                <a href="{{ route('Juego.index') }}" class="btn btn-primary btn-lg" >Dashboard</a>
                            @else
                                <a href="{{route('User.Perfil')}}" class="btn btn-primary btn-lg" >Profile y APIKEY</a>
                            @endif
                        @else
                            <a href="{{ route('login') }}" class="btn btn-primary btn-lg" >Iniciar session</a>

                            @if (Route::has('register'))
                                <a href="{{ route('register') }}" class="btn btn-primary btn-lg" >Registrarse</a>
                            @endif
                        @endauth
                    </div>
                @endif
            </div>
            <div class="lockscreen-footer text-center text-light">
                Copyright &copy; 2014-2021 <b><a href="https://adminlte.io" class="text-black">Dgames v1 API</a></b><br>
                All rights reserved
            </div>
        </div>
        <!-- /.center -->

</div>
<!-- jQuery -->
<script src="{{asset('libs/jquery/jquery.min.js')}}"></script>

<!-- Bootstrap 4 -->
<script src="{{asset('libs/bootstrap/js/bootstrap.bundle.min.js')}}"></script>

<!-- AdminLTE App -->
<script src="{{asset('js/adminlte.js')}}"></script>


</body>
</html>
