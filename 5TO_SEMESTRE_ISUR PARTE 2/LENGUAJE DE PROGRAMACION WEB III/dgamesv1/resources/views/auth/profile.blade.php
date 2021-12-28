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
        .fondo-inicio {
            background: url({{asset('img/fondo_inicio.png')}}) center;
            background-size: cover;
        }
    </style>
</head>
<body class="hold-transition lockscreen fondo-inicio">
<div class="relative flex items-top justify-center min-h-screen bg-gray-100 dark:bg-gray-900 sm:items-center py-4 sm:pt-0">

    <div class="lockscreen-wrapper">
        <div class="lockscreen-logo">
            <p class="display-3 text-light"><b>DGAMES</b>V1 API</p>
            <img class="img-fluid" src="{{asset('img/logo.png')}}" width="100px" alt="logo image">
        </div>

        <div class="card card-primary card-outline">
            <div class="card-body box-profile">
                <div class="text-center">
                    <img class="profile-user-img img-fluid img-circle"
                         src="{{asset('img/avatar3.png')}}"
                         alt="User profile picture">
                </div>

                <h3 class="profile-username text-center">{{Auth::user()->name}}</h3>


                <ul class="list-group list-group-unbordered mb-3">
                    <li class="list-group-item">
                        <b>Correo Electronico</b> <a class="float-right">{{Auth::user()->email}}</a>
                    </li>
                    <li class="list-group-item">
                        <b>Rol</b> <a href="/" class="float-right">{{Auth::user()->roles}}</a>
                    </li>
                    @if (Auth::user()->hasVerifiedEmail())
                        <li class="list-group-item">
                        <li class="list-group-item">
                            <b>Api Key</b> <a class="float-right">{{Auth::user()->api_token}}</a>
                        </li>
                        </li>
                    @else
                        <li class="list-group-item">
                            <b>Para acceder al Api verifique su Correo</b></a>
                        </li>
                    @endif
                    @if (Auth::user()->hasVerifiedEmail())
                        <li class="list-group-item">
                            <b>Email ya Verificado el {{Auth::user()->email_verified_at}}</b>
                        </li>
                    @else
                        <li class="list-group-item">
                            <b>Verificar Email</b> <a href="{{route('verification.notice')}}" class="float-right">{{Auth::user()->email}}</a>
                        </li>
                    @endif
                </ul>
                <!-- Authentication -->
                <form method="POST" action="{{ route('logout') }}">
                    @csrf
                    <a href="{{route('logout')}}" class="btn btn-primary btn-block" role="button"
                       onclick="event.preventDefault(); this.closest('form').submit();"><b>Cerrar Session</b></a>
                </form>


            </div>
            <!-- /.card-body -->
        </div>
        <!-- /.card -->

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
