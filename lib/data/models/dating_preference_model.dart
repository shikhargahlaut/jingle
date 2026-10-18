/// Gender identity options for dating preferences.
enum GenderIdentity {
  man,
  woman,
  other;

  String get label {
    switch (this) {
      case GenderIdentity.man:
        return 'Man';
      case GenderIdentity.woman:
        return 'Woman';
      case GenderIdentity.other:
        return 'Other';
    }
  }

  static GenderIdentity? fromString(String? val) {
    if (val == null) return null;
    switch (val.toLowerCase()) {
      case 'man':
      case 'male':
        return GenderIdentity.man;
      case 'woman':
      case 'female':
        return GenderIdentity.woman;
      default:
        return GenderIdentity.other;
    }
  }
}

/// "Looking For" gender preference options.
enum LookingFor {
  man,
  woman,
  everyone,
  other;

  String get label {
    switch (this) {
      case LookingFor.man:
        return 'Men';
      case LookingFor.woman:
        return 'Women';
      case LookingFor.everyone:
        return 'Everyone';
      case LookingFor.other:
        return 'Other';
    }
  }

  static LookingFor? fromString(String? val) {
    if (val == null) return null;
    switch (val.toLowerCase()) {
      case 'man':
      case 'men':
      case 'male':
        return LookingFor.man;
      case 'woman':
      case 'women':
      case 'female':
        return LookingFor.woman;
      case 'everyone':
      case 'all':
        return LookingFor.everyone;
      default:
        return LookingFor.other;
    }
  }
}

/// Relationship status options.
enum RelationshipStatus {
  single,
  inRelationship,
  complicated,
  other;

  String get label {
    switch (this) {
      case RelationshipStatus.single:
        return 'Single';
      case RelationshipStatus.inRelationship:
        return 'In a relationship';
      case RelationshipStatus.complicated:
        return "It's complicated";
      case RelationshipStatus.other:
        return 'Other';
    }
  }

  static RelationshipStatus? fromString(String? val) {
    if (val == null) return null;
    switch (val.toLowerCase()) {
      case 'single':
        return RelationshipStatus.single;
      case 'inrelationship':
      case 'in_relationship':
      case 'couple':
        return RelationshipStatus.inRelationship;
      case 'complicated':
      case "it's complicated":
        return RelationshipStatus.complicated;
      default:
        return RelationshipStatus.other;
    }
  }
}

/// Extensible relationship intent options.
enum RelationshipIntent {
  relationship,
  commitment,
  casual,
  friends,
  other;

  String get label {
    switch (this) {
      case RelationshipIntent.relationship:
        return 'Long-term relationship';
      case RelationshipIntent.commitment:
        return 'Commitment';
      case RelationshipIntent.casual:
        return 'Casual dating';
      case RelationshipIntent.friends:
        return 'New friends';
      case RelationshipIntent.other:
        return 'Other';
    }
  }

  String get shortLabel {
    switch (this) {
      case RelationshipIntent.relationship:
        return 'Relationship';
      case RelationshipIntent.commitment:
        return 'Commitment';
      case RelationshipIntent.casual:
        return 'Casual';
      case RelationshipIntent.friends:
        return 'Friends';
      case RelationshipIntent.other:
        return 'Other';
    }
  }

  static RelationshipIntent? fromString(String? val) {
    if (val == null) return null;
    switch (val.toLowerCase()) {
      case 'relationship':
      case 'long-term':
      case 'long_term':
        return RelationshipIntent.relationship;
      case 'commitment':
        return RelationshipIntent.commitment;
      case 'casual':
      case 'casual dating':
        return RelationshipIntent.casual;
      case 'friends':
      case 'new friends':
        return RelationshipIntent.friends;
      default:
        return RelationshipIntent.other;
    }
  }
}

/// Dating preference data model representing user gender, orientation, status, and intent.
class DatingPreferenceModel {
  final GenderIdentity? gender;
  final LookingFor? lookingFor;
  final RelationshipStatus? relationshipStatus;
  final RelationshipIntent? relationshipIntent;
  final int ageMin;
  final int ageMax;
  final int maxDistanceKm;

  const DatingPreferenceModel({
    this.gender,
    this.lookingFor,
    this.relationshipStatus,
    this.relationshipIntent,
    this.ageMin = 18,
    this.ageMax = 40,
    this.maxDistanceKm = 50,
  });

  DatingPreferenceModel copyWith({
    GenderIdentity? gender,
    LookingFor? lookingFor,
    RelationshipStatus? relationshipStatus,
    RelationshipIntent? relationshipIntent,
    int? ageMin,
    int? ageMax,
    int? maxDistanceKm,
  }) {
    return DatingPreferenceModel(
      gender: gender ?? this.gender,
      lookingFor: lookingFor ?? this.lookingFor,
      relationshipStatus: relationshipStatus ?? this.relationshipStatus,
      relationshipIntent: relationshipIntent ?? this.relationshipIntent,
      ageMin: ageMin ?? this.ageMin,
      ageMax: ageMax ?? this.ageMax,
      maxDistanceKm: maxDistanceKm ?? this.maxDistanceKm,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'gender': gender?.name,
      'lookingFor': lookingFor?.name,
      'relationshipStatus': relationshipStatus?.name,
      'relationshipIntent': relationshipIntent?.name,
      'ageMin': ageMin,
      'ageMax': ageMax,
      'maxDistanceKm': maxDistanceKm,
    };
  }

  factory DatingPreferenceModel.fromJson(Map<String, dynamic> json) {
    return DatingPreferenceModel(
      gender: GenderIdentity.fromString(json['gender'] as String?),
      lookingFor: LookingFor.fromString(json['lookingFor'] as String?),
      relationshipStatus:
          RelationshipStatus.fromString(json['relationshipStatus'] as String?),
      relationshipIntent:
          RelationshipIntent.fromString(json['relationshipIntent'] as String?),
      ageMin: json['ageMin'] as int? ?? 18,
      ageMax: json['ageMax'] as int? ?? 40,
      maxDistanceKm: json['maxDistanceKm'] as int? ?? 50,
    );
  }
}
