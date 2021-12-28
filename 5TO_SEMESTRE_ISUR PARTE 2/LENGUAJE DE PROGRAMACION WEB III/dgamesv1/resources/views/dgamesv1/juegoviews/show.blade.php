@extends('dgamesv1.layouts._layout')

@section('title')
    Información del Juego {{$juego->nombreJuego}}
@endsection
@section('template-title-header')
    <div class="container-fluid">
        <div class="row mb-2">
            <div class="col-sm-6">
                <h1 class="m-0">Juegos</h1>
            </div><!-- /.col -->
            <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                    <li class="breadcrumb-item"><a href="{{route('Juego.index')}}">Juegos</a></li>
                    <li class="breadcrumb-item active">Información del Juego {{$juego->nombreJuego}}</li>
                </ol>
            </div><!-- /.col -->
        </div><!-- /.row -->
    </div><!-- /.container-fluid -->
@endsection

@section('content')
    <div class="card card-solid">
        <div class="card-body">
            <div class="row">
                <div class="col-12 col-sm-6">
                    <h3 class="d-inline-block d-sm-none">{{$juego->nombreJuego}}</h3>
                    <div class="col-12">
                        <img src="{{'/imagenes/'.$juego->imagenJuego}}" class="product-image" alt="Product Image">
                    </div>
                    {{--                    <div class="col-12">--}}
                    {{--                        <img src="{{'imagenes/'.$juego->imagenJuego}}" class="product-image" alt="Product Image">--}}
                    {{--                    </div>--}}
                    {{--                    Galeria de Imagenes en desarrollo--}}
                    {{--                    <div class="col-12 product-image-thumbs">--}}
                    {{--                        <div class="product-image-thumb active"><img src="../../dist/img/prod-1.jpg" alt="Product Image"></div>--}}
                    {{--                        <div class="product-image-thumb"><img src="../../dist/img/prod-2.jpg" alt="Product Image"></div>--}}
                    {{--                        <div class="product-image-thumb"><img src="../../dist/img/prod-3.jpg" alt="Product Image"></div>--}}
                    {{--                        <div class="product-image-thumb"><img src="../../dist/img/prod-4.jpg" alt="Product Image"></div>--}}
                    {{--                        <div class="product-image-thumb"><img src="../../dist/img/prod-5.jpg" alt="Product Image"></div>--}}
                    {{--                    </div>--}}
                </div>
                <div class="col-12 col-sm-6">
                    <h3 class="my-3">{{$juego->nombreJuego}}</h3>
                    <p>{{$juego->descripcionJuego}}</p>

                    <hr>
                    <h4>Generos del Juego</h4>
                    <div class="btn-group btn-group-toggle">
                        @foreach ($juego->Generos as $JuegoGenero)
                            <label class="btn btn-default text-center ">
                                {{$JuegoGenero->nombreGenero}}
                            </label>
                        @endforeach
                    </div>
                    <hr>
                    <h4 class="mt-3">Plataformas del Juego: </h4>
                    <div class="btn-group btn-group-toggle">
                        @foreach ($juego->Plataformas as $JuegoPlataforma)
                            <label class="btn btn-default text-center ">
                                {{$JuegoPlataforma->nombreplataforma}}
                            </label>
                        @endforeach
                    </div>
                    <div class="py-2 px-3 mt-4">
                        <h5 class="mb-0">
                            Fecha de Lanzamiento: <span class="text-bold">{{$juego->fechalanzamientoJuego}}</span>
                        </h5>
                        <h5 class="mb-0">
                            Desarrolladora encargada: <span class="text-bold">{{$juego->desarrolladoraJuego}}</span>
                        </h5>
                        <h5 class="mb-0">
                            Estado del Juego: <span class="text-bold">{{$juego->estadoJuego}}</span>
                        </h5>
                    </div>

                    <div class="bg-gray py-2 px-3 mt-4">
                        <h2 class="mb-0">
                            @if ($juego->precioJuego) Precio: S./{{$juego->precioJuego}} @else No se encontro Ningun Precio @endif
                        </h2>
                    </div>
                    <div class="bg-cyan py-2 px-3 mt-4">
                        <h2 class="mb-0">
                            @if ($juego->stockJuego) Stock: {{$juego->stockJuego}} @else No se encontro Ningun Stock @endif
                        </h2>
                    </div>

                    <div class="mt-4">
                        <a href="{{route('AñadirGenero',$juego->idJuego)}}" class="btn btn-primary btn-lg btn-flat">
                            <i class="fas fa-edit fa-lg mr-2"></i>
                            Editar Generos del Juego
                        </a>
                        <a href="{{route('AñadirPlataforma',$juego->idJuego)}}" class="btn btn-primary btn-lg btn-flat">
                            <i class="fas fa-edit fa-lg mr-2"></i>
                            Editar Plataformas del Juego
                        </a>
                    </div>
                    <div class="mt-4">
                        <a href="{{route('Juego.edit',$juego->idJuego)}}" class="btn btn-warning btn-lg btn-flat">
                            <i class="fas fa-edit fa-lg mr-2"></i>
                            Editar Juego
                        </a>
                    </div>
                    {{--                <div class="mt-4">--}}
                    {{--                    <a class="btn btn-primary btn-lg btn-flat">--}}
                    {{--                        <i class="fas fa-edit fa-lg mr-2"></i>--}}
                    {{--                        Editar Galeria de Imagenes--}}
                    {{--                    </a>--}}
                    {{--                </div>--}}
                </div>




            </div>
            <div class="row mt-4 justify-content-center">
                <nav class="w-100">
                    <div class="nav nav-tabs" id="product-tab" role="tablist">
                        <a class="nav-item nav-link active" id="product-desc-tab" data-toggle="tab" href="#product-desc" role="tab" aria-controls="product-desc"
                           aria-selected="true">Descripcion</a>
                        <a class="nav-item nav-link" id="product-comments-tab" data-toggle="tab" href="#product-comments" role="tab"
                           aria-controls="product-comments" aria-selected="false">Trailer {{$juego->nombreJuego}}</a>
                    </div>
                </nav>
                <div class="tab-content p-3" id="nav-tabContent">
                    <div class="tab-pane fade show active" id="product-desc" role="tabpanel" aria-labelledby="product-desc-tab">
                        {{$juego->descripcionJuego}}
                    </div>
                    <div class="tab-pane fade" id="product-comments" role="tabpanel" aria-labelledby="product-comments-tab">
                        <div class="text-center">
                            <iframe width="800" height="560" src="https://www.youtube.com/embed/{{$juego->videoJuego}}"
                                    title="YouTube video player" frameborder="0"
                                    allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                                    allowfullscreen></iframe>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- /.card-body -->
    </div>
    <!-- /.card -->
@endsection
