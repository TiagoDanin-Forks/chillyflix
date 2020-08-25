import 'package:chillyflix/Services/TolokaService.dart';
import 'package:flutter/widgets.dart';
import 'package:transparent_image/transparent_image.dart';

class Poster extends StatelessWidget {
  final Movie item;
  const Poster(this.item,);

  @override
  Widget build(BuildContext context) {
     if (item.hasPoster) {
      return FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image: item.poster,
        fit: BoxFit.fill,
      );
    }else{
      return Image.memory(kTransparentImage, fit: BoxFit.fill);
    }
  }
}
