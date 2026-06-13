class CharacterItem {
  final String? name;
  final String? audioFile;
  final String? imageFile;
  final bool customFont;
  final List<int>? highlightIndexes;
  final double imageScale;

  const CharacterItem({
    this.name,
    this.audioFile,
    this.imageFile,
    this.customFont = false,
    this.highlightIndexes,
    this.imageScale = 2.2,
  });
}
