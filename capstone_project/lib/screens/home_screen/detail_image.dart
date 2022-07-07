import 'package:flutter/material.dart';

class DetailImage extends StatefulWidget {
  final String? imageUrl;
  const DetailImage({Key? key, this.imageUrl}) : super(key: key);

  @override
  State<DetailImage> createState() => _DetailImageState();
}

class _DetailImageState extends State<DetailImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.keyboard_arrow_left),
        ),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: InteractiveViewer(
          boundaryMargin: const EdgeInsets.all(20.0),
          minScale: 0.1,
          maxScale: 1.6,
          child: Image.network(
            '${widget.imageUrl}',
            fit: BoxFit.contain,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: CircularProgressIndicator(),
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              return Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 3),
                child: Image.asset('assets/images/nomizo-icon.png'),
              );
            },
          ),
        ),
      ),
    );
  }
}
