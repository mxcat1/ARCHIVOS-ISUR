@extends('dgamesv1.layouts._layout')

@section('title')
    Plataformas
@endsection
@section('template-title-header')
    <div class="container-fluid">
        <div class="row mb-2">
            <div class="col-sm-6">
                <h1 class="m-0">Plataforma de Juegos</h1>
            </div><!-- /.col -->
            <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                    <li class="breadcrumb-item"><a href="#">Plataformas</a></li>
                    <li class="breadcrumb-item active">Listado de Plataformas de Juegos</li>
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
                        <h3 class="card-title">Listado de Plataformas de Juegos</h3>
                        <div class="float-right">
                            <a href="{{route('Plataforma.create')}}" class="btn btn-success">Agregar Nueva Plataforma</a>
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
                                <th>Nombre de la Plataforma</th>
                                <th style="width: 300px">Acciones</th>
                            </tr>
                            </thead>
                            <tbody>
                            @foreach ($listaplataformas as $plataforma)
                                <tr>
                                    <td>{{$loop->index+1}}</td>
                                    <td>{{$plataforma->nombreplataforma}}</td>
                                    <td class="d-flex align-items-center justify-content-around" style="width: 300px">
                                        <a href="{{route('Plataforma.edit',$plataforma->idplataforma)}}" class="btn btn-warning"><i class="fas fa-edit"></i></a>
                                        <form action="{{ route('Plataforma.destroy',$plataforma->idplataforma) }}" method="POST">
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
                    {{ $listaplataformas->links() }}
                </div>
                <!-- /.card -->
            </div>
        </div>
    </div>
@endsection
@section('myscript')
    <script>
        document.onsubmit=function(){
            return confirm('¿Esta Usted Seguro de Eliminar la Plataforma?');
        }
    </script>
@endsection
