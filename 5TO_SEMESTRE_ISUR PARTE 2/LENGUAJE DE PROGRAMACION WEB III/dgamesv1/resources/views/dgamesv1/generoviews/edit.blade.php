@extends('dgamesv1.layouts._layout')

@section('title')
    Ingresar Nuevo Genero
@endsection
@section('template-title-header')
    <div class="container-fluid">
        <div class="row mb-2">
            <div class="col-sm-6">
                <h1 class="m-0">Generos</h1>
            </div><!-- /.col -->
            <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                    <li class="breadcrumb-item"><a href="#">Generos</a></li>
                    <li class="breadcrumb-item active">Ingresar Nuevo Genero de Juego</li>
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
                        <h3 class="card-title">Editar Genero</h3>
                    </div>
                    <!-- /.card-header -->

                @include('dgamesv1.partials.validacionerrors')

                <!-- form start -->
                    <form action="{{route('Genero.update',$genero->nombreGenero)}}" method="post">
                        @csrf
                        @method('PUT')
                        <input type="hidden" name="idGenero" id="idGenero" value="{{$genero->idGenero}}">
                        <div class="card-body">
                            <div class="form-group">
                                <label for="nombreGenero">Nombre del Genero</label>
                                <input type="text" class="form-control" name="nombreGenero" id="nombreGenero" value="{{$genero->nombreGenero}}" placeholder="Ingrese Nombre del Genero">
                                @error('nombreGenero')
                                <small class="text-danger">{{$message}}</small>
                                @enderror
                            </div>
                        </div>
                        <!-- /.card-body -->

                        <div class="card-footer">
                            <button type="submit" class="btn btn-primary">Editar</button>
                            <a href="{{route('Genero.index')}}" class="btn btn-danger">Cancelar</a>
                        </div>
                    </form>
                </div>
                <!-- /.card -->
            </div>
        </div>
@endsection
