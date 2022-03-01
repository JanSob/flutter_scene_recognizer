class ImageWithLabels {
  String imageUrl;
  List<String> labels;
  ImageWithLabels({required this.imageUrl, required this.labels});

  ImageWithLabels.fromJson(Map<String, Object?> json)
      : this(
          imageUrl: json['imageUrl']! as String,
          labels: json['labels']! as List<String>,
        );

  Map<String, Object?> toJson() {
    return {
      'imageUrl': imageUrl,
      'labels': labels,
    };
  }
}
