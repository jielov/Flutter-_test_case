class ImageUtils {
  static String getPNGImagePath(String name) {
    return getImagePath(name, format: "png");
//    return "images/$name.$format";
  }

  static String getImagePath(String name, {String format: "png"}) {
    return "images/$name.$format";
  }
}
