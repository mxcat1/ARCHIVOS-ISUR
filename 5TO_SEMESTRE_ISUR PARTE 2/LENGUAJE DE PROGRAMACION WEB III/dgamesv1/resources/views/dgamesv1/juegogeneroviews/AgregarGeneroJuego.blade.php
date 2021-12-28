@extends('dgamesv1.layouts._layout')

@section('title')
    Agregar Genero a {{$juego->nombreJuego}}
@endsection
@section('template-title-header')
    <div class="container-fluid">
        <div class="row mb-2">
            <div class="col-sm-6">
                <h1 class="m-0">Agregar Genero</h1>
            </div><!-- /.col -->
            <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                    <li class="breadcrumb-item"><a href="#">Agregar Genero</a></li>
                    <li class="breadcrumb-item active">Agregar Nuevo Genero al Juego</li>
                </ol>
            </div><!-- /.col -->
        </div><!-- /.row -->
    </div><!-- /.container-fluid -->
@endsection

@section('content')
    <div class="container-fluid">
        <div class="row">
            <!-- left column -->
            <div class="col-md-8 mx-auto">
                <!-- general form elements -->
                <div class="card card-primary">
                    <div class="card-header">
                        <h3 class="card-title">Agregar Genero al Juego de {{$juego->nombreJuego}}</h3>
                    </div>
                    <!-- /.card-header -->

                    @include('dgamesv1.partials.validacionerrors')

                    <h4>Generos del Juego {{$juego->nombreJuego}}</h4>
                    <div class="btn-group btn-group-toggle">
                        @foreach ($juego->Generos as $JuegoGenero)
                            <label class="btn btn-default text-center ">
                                {{$JuegoGenero->nombreGenero}}
                            </label>
                        @endforeach
                    </div>
                    <!-- form start -->
                    <form action="{{route('AñadirGenero.store')}}" method="post">
                        @csrf
                        <input type="hidden" name="juego" id="juego" value="{{$juego->idJuego}}">
                        <div class="card-body">
                            <div class="form-group">
                                <label for="generoJuego">Selecciones un Genero para agregar</label>
                                <select class="form-control" name="generoJuego" id="generoJuego">
                                    <option value="">Seleccione una Opcion</option>
                                    @foreach($listageneros as $genero)
                                        <option value="{{$genero->idGenero}}">{{$genero->nombreGenero}}</option>
                                    @endforeach
                                </select>
                                {{--                                @error('nombreGenero')--}}
                                {{--                                <small class="text-danger">{{$message}}</small>--}}
                                {{--                                @enderror--}}
                            </div>
                        </div>
                        <!-- /.card-body -->

                        <div class="card-footer">
                            <button type="submit" class="btn btn-primary">Agregar</button>
                            <a href="{{route('Juego.show',$juego->idJuego)}}" class="btn btn-danger">Cancelar</a>
                        </div>
                    </form>
                </div>
                <!-- /.card -->
            </div>
        </div>
@endsection
