class TeamStanding {
  final int position;
  final String teamName;
  final String groupName;
  final int matchesPlayed;
  final int players;
  final int wins;
  final int losses;
  final double winPercentage;
  final String logoUrl;

  TeamStanding({
    required this.position,
    required this.teamName,
    required this.groupName,
    required this.matchesPlayed,
    required this.players,
    required this.wins,
    required this.losses,
    required this.winPercentage,
    required this.logoUrl,
  });
}
