@extends('dgamesv1.layouts._layout')

@section('title')
    Agregar Plataforma al {{$juego->nombreJuego}}
@endsection
@section('template-title-header')
    <div class="container-fluid">
        <div class="row mb-2">
            <div class="col-sm-6">
                <h1 class="m-0">Agregar Plataforma</h1>
            </div><!-- /.col -->
            <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                    <li class="breadcrumb-item"><a href="#">Agregar Plataforma</a></li>
                    <li class="breadcrumb-item active">Agregar Nueva Plataforma al Juego</li>
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
                        <h3 class="card-title">Agregar Plataforma al Juego de {{$juego->nombreJuego}}</h3>
                    </div>
                    <!-- /.card-header -->

                    @include('dgamesv1.partials.validacionerrors')

                    <h4>Plataformas del Juego {{$juego->nombreJuego}}</h4>
                    <div class="btn-group btn-group-toggle">
                        @foreach ($juego->Plataformas as $JuegoPlataforma)
                            <label class="btn btn-default text-center ">
                                {{$JuegoPlataforma->nombreplataforma}}
                            </label>
                        @endforeach
                    </div>
                    <!-- form start -->
                    <form action="{{route('AñadirPlataforma.store')}}" method="post">
                        @csrf
                        <input type="hidden" name="juego" id="juego" value="{{$juego->idJuego}}">
                        <div class="card-body">
                            <div class="form-group">
                                <label for="plataformaJuego">Selecciones una Plataforma para agregar</label>
                                <select class="form-control" name="plataformaJuego" id="plataformaJuego">
                                    <option value="">Seleccione una Opcion</option>
                                    @foreach($listaPlataformas as $plataforma)
                                        <option value="{{$plataforma->idplataforma}}">{{$plataforma->nombreplataforma}}</option>
                                    @endforeach
                                </select>
                                @error('plataformaJuego')
                                <small class="text-danger">{{$message}}</small>
                                @enderror
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
