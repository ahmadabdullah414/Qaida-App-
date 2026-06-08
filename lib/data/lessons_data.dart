import 'package:flutter/material.dart';
import '../models/lesson.dart';
import '../models/intro_section.dart';

class LessonsData {
  static const List<Lesson> lessons = [
    Lesson(
      number: '1',
      name: 'The Alphabets',
      introSections: [
        IntroSection(
          text: "Assalamualaikum Wa Rahmatullahi Wabarakaatuh, I am Mufti Zayd, I will be teaching you how to read the Qur'an inshaAllah! May Allah make it easy for you! In Lesson 1, we will be learning the letters of the Arabic Alphabet. Press each letter to hear me read them out for you!",
          audioFile: 'l1_intro.mp3',
        ),
      ],
      backgroundColor: Color(0xFF3da5dd),
      textColor: Colors.white,
    ),
    Lesson(
      number: '2',
      name: 'Assorted Alphabets',
      introSections: [
        IntroSection(
          text: 'Lets read the letters of the alphabets when they are not in order.',
          audioFile: 'l2_intro.mp3',
        ),
      ],
      backgroundColor: Color(0xFFfde302),
      textColor: Color(0xFFd01b72),
    ),
    Lesson(
      number: '3',
      name: 'Letter Positions',
      introSections: [
        IntroSection(
          text: 'Each letter changes shape depending on where in the word it is. Lets learn the different shapes for each letter.',
          audioFile: 'l3_intro.mp3',
        ),
      ],
      backgroundColor: Color(0xFFee8487),
      textColor: Color(0xFF000000),
    ),
    Lesson(
      number: '4',
      name: 'Assorted Letter Positions',
      introSections: [
        IntroSection(
          text: 'Lets practice the different letters with their different shapes depending on where in the word they are!',
          audioFile: 'l4_intro.mp3',
        ),
      ],
      backgroundColor: Color(0xFFAD77B4),
      textColor: Color(0xFFFDE302),
    ),
    Lesson(
      number: '5',
      name: 'Assorted Joint Letters',
      introSections: [
        IntroSection(
          text: 'Here are some examples of some joint letters.',
          audioFile: 'l5_intro.mp3',
        ),
      ],
      backgroundColor: Color(0xFFFBF492),
      textColor: Color(0xFF241833),
    ),
    Lesson(
      number: '6',
      name: 'Fathah',
      introSections: [
        IntroSection(text: 'This is a Fathah قَ', audioFile: 'l6_intro.mp3', imageFile: 'l6_intro1.png'),
        IntroSection(text: 'Fathah adds an "a" sound to the letter وَ', audioFile: 'l6_intro.mp3', imageFile: 'l6_intro2.png'),
        IntroSection(text: 'Fathah comes above a letter ضَرَ', audioFile: 'l6_intro.mp3', imageFile: 'l6_intro3.png'),
      ],
      backgroundColor: Color(0xFF622698),
      textColor: Color(0xFF3DA5DD),
      character: ' َ  ',
    ),
    Lesson(
      number: '7',
      name: 'Kasrah',
      introSections: [
        IntroSection(text: 'This is a Kasrah قِ', audioFile: 'l7_intro.mp3', imageFile: 'l7_intro1.png'),
        IntroSection(text: 'Kasrah adds an "i" sound to the letter وِ', audioFile: 'l7_intro.mp3', imageFile: 'l7_intro2.png'),
        IntroSection(text: 'Kasrah comes below a letter اِ', audioFile: 'l7_intro.mp3', imageFile: 'l7_intro3.png'),
      ],
      backgroundColor: Color(0xFF27B349),
      textColor: Color(0xFF622698),
      character: ' ِ  ',
    ),
    Lesson(
      number: '8',
      name: 'Dhammah',
      introSections: [
        IntroSection(text: 'This is a Dhammah قُ', audioFile: 'l8_intro.mp3', imageFile: 'l8_intro1.png'),
        IntroSection(text: 'Dhammah adds an "oo" sound to the letter وُ', audioFile: 'l8_intro.mp3', imageFile: 'l8_intro2.png'),
        IntroSection(text: 'Dhammah comes above a letter هُمُ', audioFile: 'l8_intro.mp3', imageFile: 'l8_intro3.png'),
      ],
      backgroundColor: Color(0xFFFE9016),
      textColor: Color(0xFF622698),
      character: ' ُ  ',
    ),
    Lesson(
      number: '9',
      name: 'Mixed Practice',
      introSections: [
        IntroSection(text: "Let's practice some examples of word which contain Fathah, Kasrah and Dhammah.", audioFile: 'l9_intro.mp3'),
      ],
      backgroundColor: Color(0xFF3da5dd),
      textColor: Colors.white,
      character: ' َ \tِ \tُ  ',
    ),
    Lesson(
      number: '10',
      name: 'Fathatain',
      introSections: [
        IntroSection(text: 'This is a Fathatain ةً', audioFile: 'l10_intro.mp3', imageFile: 'l10_intro1.png'),
        IntroSection(text: 'Fathatain comes at the end of a word. Alif usually comes after it بًا ', audioFile: 'l10_intro.mp3', imageFile: 'l10_intro2.png'),
        IntroSection(text: "Adds an 'an' sound to the letter ءً", audioFile: 'l10_intro.mp3', imageFile: 'l10_intro3.png'),
      ],
      backgroundColor: Color(0xFFfde302),
      textColor: Color(0xFFd01b72),
      character: ' ً  ',
    ),
    Lesson(
      number: '11',
      name: 'Kasratain',
      introSections: [
        IntroSection(text: 'This is a Kasratain ةٍ', audioFile: 'l11_intro.mp3', imageFile: 'l11_intro1.png'),
        IntroSection(text: "Kasratain adds an 'in' sound to the letter بٍ", audioFile: 'l11_intro.mp3', imageFile: 'l11_intro2.png'),
        IntroSection(text: 'You will only see it below a letter ءٍ', audioFile: 'l11_intro.mp3', imageFile: 'l11_intro3.png'),
      ],
      backgroundColor: Color(0xFFee8487),
      textColor: Color(0xFF000000),
      character: ' ٍ  ',
    ),
    Lesson(
      number: '12',
      name: 'Dhammatain',
      introSections: [
        IntroSection(text: 'This is a Dhammatain ةٌ', audioFile: 'l12_intro.mp3', imageFile: 'l12_intro1.png'),
        IntroSection(text: "Dhammatain adds an 'un' sound to the letter بٌ ", audioFile: 'l12_intro.mp3', imageFile: 'l12_intro2.png'),
        IntroSection(text: 'You will only see it above a letter ءٌ', audioFile: 'l12_intro.mp3', imageFile: 'l12_intro3.png'),
      ],
      backgroundColor: Color(0xFFAD77B4),
      textColor: Color(0xFFFDE302),
      character: ' ٌ  ',
    ),
    Lesson(
      number: '13',
      name: 'Mixed Practice',
      introSections: [
        IntroSection(text: 'Lets practice a mixture of what we have learned so far!', audioFile: 'l13_intro.mp3'),
      ],
      backgroundColor: Color(0xFFFBF492),
      textColor: Color(0xFF241833),
      character: ' ً \tٍ \tٌ  ',
    ),
    Lesson(
      number: '14',
      name: 'Fathah Followed By Alif',
      introSections: [
        IntroSection(text: 'If a letter with a fatha has an alif after it,it adds an "aa" sound to the letter بَا', audioFile: 'l14_intro.mp3', imageFile: 'l14_intro1.png'),
      ],
      backgroundColor: Color(0xFF622698),
      textColor: Color(0xFF3DA5DD),
      character: ' بَا',
    ),
    Lesson(
      number: '15',
      name: 'The Mini Alif',
      introSections: [
        IntroSection(text: 'This is a Mini Alif بٰ', audioFile: 'l15_intro.mp3', imageFile: 'l15_intro1.png'),
        IntroSection(text: "It also adds an 'aa' sound to the letter بٰ", audioFile: 'l15_intro.mp3', imageFile: 'l15_intro2.png'),
        IntroSection(text: 'If there is a yaa at the end, we dont pronounce it لٰي', audioFile: 'l15_intro.mp3', imageFile: 'l15_intro3.png'),
      ],
      backgroundColor: Color(0xFF27B349),
      textColor: Color(0xFF622698),
      character: 'ٰ',
    ),
    Lesson(
      number: '16',
      name: 'Standing Kasra',
      introSections: [
        IntroSection(text: 'This is a Standing Kasra, It looks like an Alif بٖ', audioFile: 'l16_intro.mp3', imageFile: 'l16_intro1.png'),
        IntroSection(text: 'It adds an "ee" sound to the letter جٖ', audioFile: 'l16_intro.mp3', imageFile: 'l16_intro2.png'),
        IntroSection(text: 'The "ee" sound is longer than a normal Kasra اٖ', audioFile: 'l16_intro.mp3', imageFile: 'l16_intro3.png'),
      ],
      backgroundColor: Color(0xFFFE9016),
      textColor: Color(0xFF622698),
      character: ' ٖ ',
    ),
    Lesson(
      number: '17',
      name: 'Yaa Sukoon',
      introSections: [
        IntroSection(text: 'This is a Yaa Sukoon. It has a sukoon on it. Sukoon joins 2 letters together بِيْ', audioFile: 'l17_intro.mp3', imageFile: 'l17_intro1.png'),
        IntroSection(text: 'It comes after a letter with a kasra زِيْ', audioFile: 'l17_intro.mp3', imageFile: 'l17_intro2.png'),
        IntroSection(text: 'It sounds the same as the standing kasra', audioFile: 'l17_intro.mp3'),
      ],
      backgroundColor: Color(0xFF3da5dd),
      textColor: Colors.white,
      character: ' يْ ',
    ),
    Lesson(
      number: '18',
      name: 'Upside Down Dhamma',
      introSections: [
        IntroSection(text: 'This is a Upside Down Dhamma بٗ', audioFile: 'l18_intro.mp3', imageFile: 'l18_intro1.png'),
        IntroSection(text: 'It adds an "ooo" sound to the letter تٗ', audioFile: 'l18_intro.mp3', imageFile: 'l18_intro2.png'),
        IntroSection(text: 'The "ooo" sound is longer than a dhamma سٗ', audioFile: 'l18_intro.mp3', imageFile: 'l18_intro3.png'),
      ],
      backgroundColor: Color(0xFFfde302),
      textColor: Color(0xFFd01b72),
      character: ' ٗ ',
    ),
    Lesson(
      number: '19',
      name: 'Wow Sukoon',
      introSections: [
        IntroSection(text: 'This is a Wow Sukoon خُوْ', audioFile: 'l19_intro.mp3', imageFile: 'l19_intro1.png'),
        IntroSection(text: 'It comes after a letter with a Dhamma خُوْ', audioFile: 'l19_intro.mp3', imageFile: 'l19_intro2.png'),
        IntroSection(text: 'It adds the same "ooo" sound as a upside down Dhamma اُوْ', audioFile: 'l19_intro.mp3', imageFile: 'l19_intro3.png'),
      ],
      backgroundColor: Color(0xFFee8487),
      textColor: Color(0xFF000000),
      character: ' وْ ',
    ),
    Lesson(
      number: '20',
      name: 'Leen Wow',
      introSections: [
        IntroSection(text: 'This is a Leen Wow its a wow with a sukoon on اَوْ', audioFile: 'l20_intro.mp3', imageFile: 'l20_intro1.png'),
        IntroSection(text: 'It comes after a letter with a fatha ذَوْ', audioFile: 'l20_intro.mp3', imageFile: 'l20_intro2.png'),
        IntroSection(text: 'It makes a "aww" sound اَوْ', audioFile: 'l20_intro.mp3', imageFile: 'l20_intro3.png'),
      ],
      backgroundColor: Color(0xFFAD77B4),
      textColor: Color(0xFFFDE302),
    ),
    Lesson(
      number: '20 Part(2)',
      name: 'Leen Yaa',
      introSections: [
        IntroSection(text: 'This is a Leen Yaa its a yaa with a sukoon on اَيْ', audioFile: 'l20_2_intro.mp3', imageFile: 'l20_2_intro1.png'),
        IntroSection(text: 'It comes after a letter with a fatha ذَيْ', audioFile: 'l20_2_intro.mp3', imageFile: 'l20_2_intro2.png'),
        IntroSection(text: 'It makes a "ayy" sound وَيْ', audioFile: 'l20_2_intro.mp3', imageFile: 'l20_2_intro3.png'),
      ],
      backgroundColor: Color(0xFFFBF492),
      textColor: Color(0xFF241833),
    ),
    Lesson(
      number: '20 Part(3)',
      name: 'Mixed Practice',
      introSections: [
        IntroSection(text: 'In This lesson we are going to practice reading some words from the Quran!', audioFile: 'l20_3_intro.mp3'),
      ],
      backgroundColor: Color(0xFF622698),
      textColor: Color(0xFF3DA5DD),
    ),
    Lesson(
      number: '20 Part(4)',
      name: 'Mixed Practice',
      introSections: [
        IntroSection(text: 'Lets continue with some words from the Quran!', audioFile: 'l20_4_intro.mp3'),
      ],
      backgroundColor: Color(0xFF27B349),
      textColor: Color(0xFF622698),
    ),
    Lesson(
      number: '21',
      name: 'Sukoon',
      introSections: [
        IntroSection(text: 'This is a Sukoon اِبْ', audioFile: 'l21_intro.mp3', imageFile: 'l21_intro1.png'),
        IntroSection(text: 'A letter with a Sukoon is called a Saakin letter اُدْ', audioFile: 'l21_intro.mp3', imageFile: 'l21_intro2.png'),
        IntroSection(text: 'The Saakin letter connects to the letter before it سَبْ', audioFile: 'l21_intro.mp3', imageFile: 'l21_intro3.png'),
      ],
      backgroundColor: Color(0xFFFE9016),
      textColor: Color(0xFF622698),
      character: 'ْ',
    ),
    Lesson(
      number: '21 Part(2)',
      name: 'Sukoon Practice',
      introSections: [
        IntroSection(text: 'Lets practice some words with a sukoon on them, this time there are more than 2 letters joined together! سَبْعَ', audioFile: 'l21_2_intro.mp3', imageFile: 'l21_2_intro1.png'),
      ],
      backgroundColor: Color(0xFF3da5dd),
      textColor: Colors.white,
      character: ' ْ  ',
    ),
    Lesson(
      number: '22',
      name: 'Tashdeed',
      introSections: [
        IntroSection(text: 'This is a Shaddah or Tashdeed اَشَّ', audioFile: 'l22_intro.mp3', imageFile: 'l22_intro1.png'),
        IntroSection(text: 'Its like a sukoon, but you say the harakah on the letter with the tashdeed اُبُّ', audioFile: 'l22_intro.mp3', imageFile: 'l22_intro2.png'),
        IntroSection(text: 'Its like saying the letter 2 times اَتَّ', audioFile: 'l22_intro.mp3', imageFile: 'l22_intro3.png'),
      ],
      backgroundColor: Color(0xFFfde302),
      textColor: Color(0xFFd01b72),
      character: ' ّ  ',
    ),
    Lesson(
      number: '22 Part(2)',
      name: 'Tashdeed Practice',
      backgroundColor: Color(0xFFee8487),
      textColor: Color(0xFF000000),
      character: ' ّ  ',
    ),
    Lesson(
      number: '23',
      name: 'Small Madd',
      introSections: [
        IntroSection(text: 'This is a Small madd لَاۤ ', audioFile: 'l23_intro.mp3', imageFile: 'l23_intro1.png'),
        IntroSection(text: 'You should stretch the sound of the letter that its on مَاۤ ', audioFile: 'l23_intro.mp3', imageFile: 'l23_intro2.png'),
        IntroSection(text: 'Small madd stretches for 2 counts اِذَاۤ  ', audioFile: 'l23_intro.mp3', imageFile: 'l23_intro3.png'),
      ],
      backgroundColor: Color(0xFFAD77B4),
      textColor: Color(0xFFFDE302),
      character: 'ۤ',
    ),
    Lesson(
      number: '23 (Part 2)',
      name: 'Long Madd',
      introSections: [
        IntroSection(text: 'This is a Long madd بَآ', audioFile: 'l23_2_intro.mp3', imageFile: 'l23_2_intro1.png'),
        IntroSection(text: 'You should stretch the sound of the letter that its on - longer than small madd بَلَآءٌ', audioFile: 'l23_2_intro.mp3', imageFile: 'l23_2_intro2.png'),
        IntroSection(text: 'Long madd stretches for 4 - 5 counts يُرَآءُ', audioFile: 'l23_2_intro.mp3', imageFile: 'l23_2_intro3.png'),
      ],
      backgroundColor: Color(0xFFFBF492),
      textColor: Color(0xFF241833),
      character: 'ٓ',
    ),
    Lesson(
      number: '24',
      name: 'Connecting Sounds',
      introSections: [
        IntroSection(text: "In the Qur'an, you will find various ways to connect 2 words together,We will look through some of them in this lesson.", audioFile: 'l24_intro.mp3'),
      ],
      backgroundColor: Color(0xFF622698),
      textColor: Color(0xFF3DA5DD),
      character: 'صُمٌّۢ بُكْمٌ',
    ),
    Lesson(
      number: '25',
      name: 'Silent Letters',
      introSections: [
        IntroSection(text: 'This is a Silent Letter مِائَةَ', audioFile: 'l25_intro.mp3', imageFile: 'l25_intro1.png'),
        IntroSection(text: "It has no harakah and is not joined to the next letter. Silent letters are still written in the Qur'an, but we do not pronounce them.", audioFile: 'l25_intro.mp3'),
      ],
      backgroundColor: Color(0xFF27B349),
      textColor: Color(0xFF622698),
    ),
    Lesson(
      number: '26',
      name: 'The Openers',
      introSections: [
        IntroSection(text: "These are The Openers, Each letter is read separately. For example: الٓمٓ  is read as Alif, Laam, Meem. Only Allah knows their meaning! It is a miracle of the Qur'an. We read them, but their meanings are known only to Allah!", audioFile: 'l26_intro.mp3'),
      ],
      backgroundColor: Color(0xFFFE9016),
      textColor: Color(0xFF622698),
    ),
    Lesson(
      number: '27',
      name: 'Stopping',
      introSections: [
        IntroSection(text: 'When we stop on a word ending with fathatain, we read it as if it ends with a Fathah followed by Alif\n  حُكْمَا', audioFile: 'l27_intro1.mp3', imageFile: 'l27_intro1.png'),
        IntroSection(text: 'When we stop on a word ending with small ة, we read it as a ه  sakin.', audioFile: 'l27_intro2.mp3'),
        IntroSection(text: '  ايَهْ', audioFile: 'l27_intro2.mp3', imageFile: 'l27_intro2.png'),
        IntroSection(text: 'When we stop on a word ending with other letters, the last letter is read with a sukoon.\n  قَيِّمْ', audioFile: 'l27_intro3.mp3', imageFile: 'l27_intro3.png'),
      ],
      backgroundColor: Color(0xFF3da5dd),
      textColor: Colors.white,
      character: '○',
    ),
    Lesson(
      number: '27 (Part 2)',
      name: 'Stop Examples',
      introSections: [
        IntroSection(text: "Lets go through some examples of stops in the Qur'an.", audioFile: 'l27_2_intro.mp3'),
      ],
      backgroundColor: Color(0xFFfde302),
      textColor: Color(0xFFd01b72),
    ),
    Lesson(
      number: '28',
      name: 'Signs & Symbols',
      introSections: [
        IntroSection(text: "In the Qur'an, there are many small signs and symbols that help us read correctly. These marks tell us when to pause, stop, continue, or even make sujood. In this lesson, we will learn what each of these symbols mean, and how to follow them when reading the Qur'an.", audioFile: 'l28_intro.mp3'),
      ],
      backgroundColor: Color(0xFFee8487),
      textColor: Color(0xFF000000),
    ),
    Lesson(
      number: '29',
      name: 'Quran Words Practice',
      introSections: [
        IntroSection(text: "In this section, we will practice reading real words from the Qur'an. These words come from different surahs and help us become more confident. Let's read them carefully, slowly, and with the correct pronunciation.", audioFile: 'l29_intro.mp3'),
      ],
      backgroundColor: Color(0xFFAD77B4),
      textColor: Color(0xFFFDE302),
    ),
    Lesson(
      number: '30',
      name: 'Quran Practice',
      introSections: [
        IntroSection(text: "In this lesson, we will read some short sentences from the Qur'an. Some of the meanings are written in English to help us understand. Let's read slowly and clearly, and try our best to read nicely!", audioFile: 'l30_intro.mp3'),
      ],
      backgroundColor: Color(0xFFFBF492),
      textColor: Color(0xFF241833),
    ),
    Lesson(
      number: '30 (Part 2)',
      name: 'Quran Practice',
      introSections: [
        IntroSection(text: 'In This lesson we are going to practice reading some words from the Quran!', audioFile: 'l30_2_intro.mp3'),
      ],
      backgroundColor: Color(0xFF622698),
      textColor: Color(0xFF3DA5DD),
    ),
  ];
}
