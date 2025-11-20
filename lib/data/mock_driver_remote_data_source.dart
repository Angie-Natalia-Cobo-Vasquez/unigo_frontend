import '../models/driver.dart';

class MockDriverRemoteDataSource {
  Future<List<Driver>> fetchDrivers() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return const [
      Driver(
        name: 'Adrián Saavedra',
        profession: 'Ingeniería Industrial',
        vehicle: 'Moto',
        rating: 4.5,
        reviews: 12,
        passengers: 32,
        bio:
            'Soy Adrián Saavedra, estudiante de 5 semestre de Ingeniería Industrial en la UCEVA. Vivo en Buga y estaría encantado de llevarte. Leer más...',
        imageUrl: 'assets/images/adrian.png',
        ridePrice: 8000,
        city: 'Buga',
      ),
      Driver(
        name: 'Daniel Hernández',
        profession: 'Psicología',
        vehicle: 'Carro',
        rating: 4.9,
        reviews: 18,
        passengers: 48,
        bio:
            'Conozco las rutas más rápidas y cómodas para llevarte a clase. Seguridad y puntualidad garantizadas.',
        imageUrl: 'assets/images/Hernandez.png',
        ridePrice: 10000,
        city: 'Andalucía',
      ),
      Driver(
        name: 'Daniela Jojoa',
        profession: 'Psicología',
        vehicle: 'Carro',
        rating: 4.0,
        reviews: 7,
        passengers: 14,
        bio:
            'Soy conocido por llevar a mis pasajeros a sus destinos con seguridad y puntualidad.',
        imageUrl: 'assets/images/Daniela.png',
        ridePrice: 8000,
        city: 'Buga',
      ),
      Driver(
        name: 'Pedro Lucumí',
        profession: 'Derecho',
        vehicle: 'Moto',
        rating: 4.5,
        reviews: 19,
        passengers: 32,
        bio:
            'Me gusta mucho la música y la cultura, por eso me apasiona conducir. Me encanta ayudar a mis pasajeros a llegar a sus destinos con seguridad y puntualidad.',
        imageUrl: 'assets/images/Pedro.png',
        ridePrice: 10000,
        city: 'Buenaventura',
      ),
      Driver(
        name: 'Giamcito-kun',
        profession: 'Medicina',
        vehicle: 'Moto',
        rating: 4.5,
        reviews: 15,
        passengers: 32,
        bio:
            'Apasionado por la medicina y la tecnología, me encanta conducir y las motocicletas.',
        imageUrl: 'assets/images/kun.png',
        ridePrice: 15000,
        city: 'Trujillo',
      ),
      Driver(
        name: 'Carlos Ramírez',
        profession: 'Edu. Física',
        vehicle: 'Moto',
        rating: 3.8,
        reviews: 21,
        passengers: 28,
        bio:
            'Aficionado por el fútbol y los deportes en general, me encanta conducir y las motocicletas.',
        imageUrl: 'assets/images/Carlos.png',
        ridePrice: 5000,
        city: 'Tuluá',
      ),
      Driver(
        name: 'Laura Martinez',
        profession: 'Contaburia publica',
        vehicle: 'Carro',
        rating: 4.7,
        reviews: 25,
        passengers: 41,
        bio:
            'Estudiante de 5 semestre de Contabilidad en la UCEVA. Vivo en Buga y estaría encantado de llevarte.',
        imageUrl: 'assets/images/Laura.png',
        ridePrice: 7500,
        city: 'Buga',
      ),
      Driver(
        name: 'Diego Vargas',
        profession: 'Docente Facaec',
        vehicle: 'Carro',
        rating: 4.2,
        reviews: 8,
        passengers: 17,
        bio:
            'Docente Facaec de tiempo completo, con amplia experiencia y vocación para enseñar y educar.',
        imageUrl: 'assets/images/Diego.png',
        ridePrice: 6000,
        city: 'Tuluá',
      ),
    ];
  }
}
