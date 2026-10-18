import '../models/user_model.dart';
import '../models/media_compatibility_model.dart';

/// Abstract service for calculating or fetching compatibility between two users.
abstract class CompatibilityService {
  /// Resolves the compatibility score and detailed breakdown between two users.
  MediaCompatibilityModel getCompatibility(UserModel current, UserModel other);
}

/// Default compatibility service respecting backend/model values with demo fixture fallback.
class DefaultCompatibilityService implements CompatibilityService {
  @override
  MediaCompatibilityModel getCompatibility(UserModel current, UserModel other) {
    // If the profile already has a precomputed compatibility model, use it directly
    if (other.compatibility != null) {
      return other.compatibility!;
    }

    // If the profile has an existing musicSimilarity score from backend/mock, preserve that score
    final score = other.musicSimilarity > 0 ? other.musicSimilarity : 75;

    // Resolve common genres
    final myGenreNames = current.favoriteGenres.map((g) => g.name.toLowerCase()).toSet();
    final sharedGenres = other.favoriteGenres
        .where((g) => myGenreNames.contains(g.name.toLowerCase()))
        .map((g) => g.name)
        .toList();

    // Resolve common artists
    final myArtistNames = current.favoriteArtists.map((a) => a.name.toLowerCase()).toSet();
    final sharedArtists = other.favoriteArtists
        .where((a) => myArtistNames.contains(a.name.toLowerCase()))
        .map((a) => a.name)
        .toList();

    // Fallbacks for rich UI demo display if lists are empty
    final displayGenres = sharedGenres.isNotEmpty
        ? sharedGenres
        : other.favoriteGenres.map((g) => g.name).take(2).toList();
    final displayArtists = sharedArtists.isNotEmpty
        ? sharedArtists
        : other.favoriteArtists.map((a) => a.name).take(2).toList();
    final displayShows = other.favoriteShows.map((s) => s.title).take(2).toList();
    final displayInterests = other.activities.map((a) => a.title).toList();

    return MediaCompatibilityModel(
      overallScore: score,
      musicMatchPercentage: (score * 1.05).clamp(0, 100).toInt(),
      showMatchPercentage: (score * 0.9).clamp(0, 100).toInt(),
      sharedGenres: displayGenres,
      sharedArtists: displayArtists,
      sharedShows: displayShows,
      sharedInterests: displayInterests,
    );
  }
}
