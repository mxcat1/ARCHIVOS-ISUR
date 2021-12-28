@extends('dgamesv1.layouts._layout')

@section('title')
    Ingresar Nuevo Juego
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
                    <li class="breadcrumb-item active">Ingresar Nuevo Juego</li>
                </ol>
            </div><!-- /.col -->
        </div><!-- /.row -->
    </div><!-- /.container-fluid -->
@endsection

@section('content')
    <div class="container-fluid" x-data="videosbus()">
        <div class="row">
            <!-- left column -->
            <div class="col-md-8 mx-auto">
                <!-- general form elements -->
                <div class="card card-primary">
                    <div class="card-header">
                        <h3 class="card-title">Nuevo Juego</h3>
                    </div>
                    <!-- /.card-header -->

                    @include('dgamesv1.partials.validacionerrors')

                    <!-- form start -->
                    <form action="{{route('Juego.store')}}" method="post" enctype="multipart/form-data">
                        @csrf
                        <div class="card-body">
                            <div class="form-group">
                                <label for="nombreJuego">Nombre del Juego</label>
                                <input type="text" class="form-control" name="nombreJuego" id="nombreJuego" value="{{ old('nombreJuego') }}" placeholder="Ingrese Nombre del Juego">
                                @error('nombreJuego')
                                <small class="text-danger">{{$message}}</small>
                                @enderror
                            </div>
                            <div class="form-group">
                                <label for="descripcionJuego">Descripcion del Juego</label>
                                <textarea name="descripcionJuego" class="form-control" id="descripcionJuego" cols="30" rows="10">{{ old('descripcionJuego') }}</textarea>
                                @error('descripcionJuego')
                                <small class="text-danger">{{$message}}</small>
                                @enderror
                            </div>
                            <div class="form-group">
                                <label for="fechalanzamientoJuego">Fecha de Lanzamiento Juego</label>
                                <input type="date" class="form-control" name="fechalanzamientoJuego" id="fechalanzamientoJuego" value="{{ old('fechalanzamientoJuego') }}" placeholder="Fecha de Lanzamiento">
                                @error('fechalanzamientoJuego')
                                <small class="text-danger">{{$message}}</small>
                                @enderror
                            </div>
                            <div class="form-group">
                                <label for="desarrolladoraJuego">Desarrolladora del Juego</label>
                                <input type="text" class="form-control" name="desarrolladoraJuego" id="desarrolladoraJuego" value="{{ old('desarrolladoraJuego') }}" placeholder="Desarrolladora del Juego">
                                @error('fechalanzamientoJuego')
                                <small class="text-danger">{{$message}}</small>
                                @enderror
                            </div>
                            <div class="form-group">
                                <label for="imagenJuego">Imagen del Banner del Juego</label>
                                <div class="input-group">
                                    <div class="custom-file">
                                        <input type="file" class="custom-file-input" name="imagenJuego" id="imagenJuego">
                                        <label class="custom-file-label" for="imagenJuego">Escoja la Imagen</label>
                                    </div>
                                    <div class="input-group-append">
                                        <span class="input-group-text">Subiendo</span>
                                    </div>
                                </div>
                                @error('imagenJuego')
                                <small class="text-danger">{{$message}}</small>
                                @enderror
                            </div>
                            <div class="form-group">
                                <label>Buscar Video del Juego</label>
                                <input type="text" class="form-control" x-model="texto"   placeholder="ingrese el nombre dele video a buscar">
                                <button type="button" class="btn btn-dark" x-on:click="buscandovideo(texto)">Buscar</button>
                            </div>
                            <div class="pre-scrollable">
                                <template x-for="video in videosp" :key="video.id.videoId">
                                    <div class="media">
                                        <img x-bind:src="video.snippet.thumbnails.default.url" class="mr-3" x-bind:alt="video.snippet.title">
                                        <div class="media-body">
                                            <h5 class="mt-0" x-text="video.snippet.title"></h5>
                                            <p x-text="video.snippet.description"></p>
                                            <button class="btn btn-dark" type="button" x-on:click="idvideo=video.id.videoId">Escoger</button>
                                            <a class="btn btn-danger" x-bind:href="'https://www.youtube.com/watch?v='+video.id.videoId" target="_blank">Ver en You Tube</a>
                                        </div>
                                        <hr>
                                    </div>
                                </template>
                            </div>
                            <div class="form-group">
                                <label for="videoJuego">Trailer del Juego</label>
                                <input type="text" class="form-control" name="videoJuego" id="videoJuego" x-bind:value="idvideo" readonly placeholder="Trailer del Juego">
                                @error('videoJuego')
                                <small class="text-danger">{{$message}}</small>
                                @enderror
                            </div>
                            <div class="form-group">
                                <label for="precioJuego">Precio del Juego</label>
                                <input type="number" class="form-control" name="precioJuego" id="precioJuego" value="{{ old('precioJuego') }}" placeholder="Precio Estimado del Juego">
                            </div>
                            <div class="form-group">
                                <label for="stockJuego">Stock Juego</label>
                                <input type="number" class="form-control" name="stockJuego" id="stockJuego" value="{{ old('stockJuego') }}" placeholder="Stock Actual del Juego">
                            </div>
                            <div class="form-group">
                                <label for="estadoJuego">Estado del Juego</label>
                                <select class="form-control" name="estadoJuego" id="estadoJuego">
                                    <option value="">Seleccione una Opcion</option>
                                    <option value="Activo">Activo</option>
                                    <option value="Inactivo">Inactivo</option>
                                    <option value="Descontinuado">Descontinuado</option>
                                    <option value="Sin Especificar">Sin Especificar</option>
                                </select>
                            </div>
                        </div>
                        <!-- /.card-body -->

                        <div class="card-footer">
                            <button type="submit" class="btn btn-primary">Crear</button>
                            <a href="{{route('Juego.index')}}" class="btn btn-danger">Cancelar</a>
                        </div>
                    </form>
                </div>
                <!-- /.card -->
            </div>
        </div>
@endsection
@section('myscript')
            <script>
                function videosbus(){
                    return {
                        texto: '',
                        idvideo:'',
                        videosp:[],
                        buscandovideo(textoa){
                            fetch(`https://www.googleapis.com/youtube/v3/search?key=AIzaSyAPDevC17LictcJxPznDA_cr15q5Pz70sY&q=${textoa}&maxResults=10&part=snippet`,
                                {
                                    method: 'GET',
                                    mode: 'cors',
                                })
                                .then(response => response.json())
                                .then(json=> this.videosp = json.items)
                        }
                    }
                }
            </script>
@endsection
