const GOOGLE_API_KEY = 'AIzaSyBg9yn5JtQgKRFbg6FCTy4ewbF24kRuAYI';

class LocationHelper {
  static String generateLocationPreviewimage(
      {required double latitue, required double longitude}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitue,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:C%7C$latitue,$longitude &key=$GOOGLE_API_KEY';
  }
}
