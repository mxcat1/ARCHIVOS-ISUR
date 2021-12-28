@extends('dgamesv1.layouts._layout')

@section('title')
    Generos
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
                    <li class="breadcrumb-item active">Listado de Generos de Juegos</li>
                </ol>
            </div><!-- /.col -->
        </div><!-- /.row -->
    </div><!-- /.container-fluid -->
@endsection

@section('content')
    <div class="container-fluid">
        <div class="row">
            <div class="col-sm-12">
                <div class="card">
                    <div class="card-header">
                        <h3 class="card-title">Listado de Generos de Juegos</h3>
                        <div class="float-right">
                            <a href="{{route('Genero.create')}}" class="btn btn-success">Agregar Nuevo Genero</a>
                        </div>
                    </div>
                    @if ($message = Session::get('success'))
                        <div class="alert alert-success">
                            <p>{{ $message }}</p>
                        </div>
                    @endif
                <!-- /.card-header -->
                    <div class="card-body">
                        <table class="table table-bordered">
                            <thead>
                            <tr>
                                <th style="width: 10px">#</th>
                                <th>Nombre del Genero</th>
                                <th style="width: 300px">Acciones</th>
                            </tr>
                            </thead>
                            <tbody>
                            @foreach ($listageneros as $genero)
                                <tr>
                                    <td>{{$loop->index+1}}</td>
                                    <td>{{$genero->nombreGenero}}</td>
                                    <td class="d-flex align-items-center justify-content-around" style="width: 300px">
                                        <a href="{{route('Genero.edit',$genero->idGenero)}}" class="btn btn-warning"><i class="fas fa-edit"></i></a>
                                        <form action="{{ route('Genero.destroy',$genero->idGenero) }}" method="POST">
                                            @csrf
                                            @method('DELETE')
                                            <button type="submit" class="btn btn-danger delete" ><i class="fas fa-trash-alt"></i></button>
                                        </form>
                                        <a href="" class="btn btn-info"><i class="fas fa-eye"></i></a>
                                        {{--                                        Boton para ver todas las fotos de una juego En desarrollo--}}
                                        {{--                                        <a href="" class="btn btn-info"><i class="far fa-image"></i></a>--}}
                                    </td>
                                </tr>
                            @endforeach
                            </tbody>
                        </table>
                    </div>
                    {{ $listageneros->links() }}
                </div>
                <!-- /.card -->
            </div>
        </div>
    </div>
@endsection
@section('myscript')
    <script>
        document.onsubmit=function(){
            return confirm('¿Esta Usted Seguro de Eliminar el Genero?');
        }
    </script>
@endsection
