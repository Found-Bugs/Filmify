import 'package:filmify/widgets/custom_cinema_card.dart';
import 'package:filmify/widgets/custom_header.dart';
import 'package:flutter/material.dart';

class Cinemas extends StatelessWidget {
  const Cinemas({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomHeader(
      title: "Nearest Cinema",
      hintText: "Cari Judul Film",
      content: [
        CustomCinemaCard(
          cinemaName: "Transmart MX XXI",
          address:
              "Mall Transmart, Jl. Veteran Lt. 5, Penanggungan, Kec. Klojen, Kota Malang, Jawa Timur 65113",
          logoPath: "lib/assets/images/hero.png",
        ),
        CustomCinemaCard(
          cinemaName: "Cinepolis Malang Town Square",
          address:
              "Malang Town Square, Jl. Veteran Lt. 5, Penanggungan, Kec. Klojen, Kota Malang, Jawa Timur 65113",
          logoPath: "lib/assets/images/hero.png",
        ),
        CustomCinemaCard(
          cinemaName: "Mopic Cinemas Malang",
          address:
              "Jl. Soekarno  Hatta No.9, Mojolangu, Kec. Lowokwaru, Kota Malang, Jawa Timur 65141",
          logoPath: "lib/assets/images/hero.png",
        ),
        CustomCinemaCard(
          cinemaName: "Araya XXI",
          address:
              "Komp. Araya Business Center, Jl. R. Bimbing Indah Megah No.2, Purwodadi, Kec. Blimbing, Kota Malang, Jawa Timur 65126",
          logoPath: "lib/assets/images/hero.png",
        ),
        CustomCinemaCard(
          cinemaName: "Movimax Sarinah",
          address:
              "Sarinah Plaza, Jl. Jenderal Basuki Rahmat No.26, Kiduldalem, Kec. Klojen, Kota Malang, Jawa Timur 65119",
          logoPath: "lib/assets/images/hero.png",
        ),
      ],
    );
  }
}
