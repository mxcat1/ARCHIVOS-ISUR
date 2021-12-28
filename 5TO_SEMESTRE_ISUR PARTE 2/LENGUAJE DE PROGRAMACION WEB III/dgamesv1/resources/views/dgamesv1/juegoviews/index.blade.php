@extends('dgamesv1.layouts._layout')

@section('title')
    Juegos
@endsection
@section('template-title-header')
    <div class="container-fluid">
        <div class="row mb-2">
            <div class="col-sm-6">
                <h1 class="m-0">Juegos</h1>
            </div><!-- /.col -->
            <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                    <li class="breadcrumb-item"><a href="#">Juegos</a></li>
                    <li class="breadcrumb-item active">Listado de Juegos</li>
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
                        <h3 class="card-title">Listado de Juegos</h3>
                        <div class="float-right">
                            <a href="{{route('Juego.create')}}" class="btn btn-success">Agregar Nuevo Juego</a>
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
                                <th>Nombre</th>
                                <th>Fecha Lanzamiento</th>
                                <th>Desarrolladora</th>
                                <th>Imagen</th>
                                <th>Acciones</th>
                            </tr>
                            </thead>
                            <tbody>
                            @foreach ($listaJuegos as $juego)
                                <tr>
                                    <td>{{$loop->index+1}}</td>
                                    <td>{{$juego->nombreJuego}}</td>
                                    <td>{{$juego->fechalanzamientoJuego}}</td>
                                    <td>{{$juego->desarrolladoraJuego}}</td>
                                    <td><img src="/imagenes/{{$juego->imagenJuego}}" width="100px" alt="{{$juego->nombreJuego}}"></td>
                                    <td class="d-flex align-items-center justify-content-around">
                                        <a href="{{route('Juego.edit',$juego->idJuego)}}" class="btn btn-warning"><i class="fas fa-edit"></i></a>
                                        <form action="{{ route('Juego.destroy',$juego->idJuego) }}" method="POST">
                                            @csrf
                                            @method('DELETE')
                                            <button type="submit" class="btn btn-danger delete" ><i class="fas fa-trash-alt"></i></button>
                                        </form>
                                        <a href="{{route('Juego.show',$juego->idJuego)}}" class="btn btn-info"><i class="fas fa-eye"></i></a>
{{--                                        Boton para ver todas las fotos de una juego En desarrollo--}}
{{--                                        <a href="" class="btn btn-info"><i class="far fa-image"></i></a>--}}
                                    </td>
                                </tr>
                            @endforeach
                            </tbody>
                        </table>
                    </div>
                    {{ $listaJuegos->links() }}
                </div>
                <!-- /.card -->
            </div>
        </div>
    </div>
@endsection
@section('myscript')
    <script>
        document.onsubmit=function(){
            return confirm('¿Esta Usted Seguro de Eliminar El Juego?');
        }
    </script>
@endsection
