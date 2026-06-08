class CharacterItem {
  final String? name;
  final String? audioFile;
  final String? imageFile;
  final bool customFont;
  final List<int>? highlightIndexes;

  const CharacterItem({
    this.name,
    this.audioFile,
    this.imageFile,
    this.customFont = false,
    this.highlightIndexes,
  });
}
