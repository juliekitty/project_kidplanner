// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Kid Planner`
  String get General_appName {
    return Intl.message(
      'Kid Planner',
      name: 'General_appName',
      desc: '',
      args: [],
    );
  }

  /// `GO`
  String get General_go {
    return Intl.message(
      'GO',
      name: 'General_go',
      desc: '',
      args: [],
    );
  }

  /// `You do not have enough point to play!`
  String get HP_SnackBar_NotEnoughPoints {
    return Intl.message(
      'You do not have enough point to play!',
      name: 'HP_SnackBar_NotEnoughPoints',
      desc: '',
      args: [],
    );
  }

  /// `Home page`
  String get HP_PageTitle {
    return Intl.message(
      'Home page',
      name: 'HP_PageTitle',
      desc: '',
      args: [],
    );
  }

  /// `What's your name?`
  String get HP_AlertDialog_Title {
    return Intl.message(
      'What\'s your name?',
      name: 'HP_AlertDialog_Title',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get HP_AlertDialog_Form_LabelText {
    return Intl.message(
      'Name',
      name: 'HP_AlertDialog_Form_LabelText',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your name`
  String get HP_AlertDialog_Form_ValidationText {
    return Intl.message(
      'Please enter your name',
      name: 'HP_AlertDialog_Form_ValidationText',
      desc: '',
      args: [],
    );
  }

  /// `Begin a routine`
  String get HP_Carousel_Routines {
    return Intl.message(
      'Begin a routine',
      name: 'HP_Carousel_Routines',
      desc: '',
      args: [],
    );
  }

  /// `Morning Routine`
  String get HP_Carousel_Routine_MorningTitle {
    return Intl.message(
      'Morning Routine',
      name: 'HP_Carousel_Routine_MorningTitle',
      desc: '',
      args: [],
    );
  }

  /// `Begin your morning routine!`
  String get HP_Carousel_Routine_MorningDescr {
    return Intl.message(
      'Begin your morning routine!',
      name: 'HP_Carousel_Routine_MorningDescr',
      desc: '',
      args: [],
    );
  }

  /// `Bedtime Routine`
  String get HP_Carousel_Routine_BedtimeTitle {
    return Intl.message(
      'Bedtime Routine',
      name: 'HP_Carousel_Routine_BedtimeTitle',
      desc: '',
      args: [],
    );
  }

  /// `Begin your bedtime routine!`
  String get HP_Carousel_Routine_BedtimeDescr {
    return Intl.message(
      'Begin your bedtime routine!',
      name: 'HP_Carousel_Routine_BedtimeDescr',
      desc: '',
      args: [],
    );
  }

  /// `Win bonus points`
  String get HP_Carousel_Bonus {
    return Intl.message(
      'Win bonus points',
      name: 'HP_Carousel_Bonus',
      desc: '',
      args: [],
    );
  }

  /// `Bonus Tasks`
  String get HP_Carousel_Bonus_TasksTitle {
    return Intl.message(
      'Bonus Tasks',
      name: 'HP_Carousel_Bonus_TasksTitle',
      desc: '',
      args: [],
    );
  }

  /// `Win bonus points!`
  String get HP_Carousel_Bonus_TasksDescr {
    return Intl.message(
      'Win bonus points!',
      name: 'HP_Carousel_Bonus_TasksDescr',
      desc: '',
      args: [],
    );
  }

  /// `Planning advices`
  String get HP_Carousel_Bonus_AdvicesTitle {
    return Intl.message(
      'Planning advices',
      name: 'HP_Carousel_Bonus_AdvicesTitle',
      desc: '',
      args: [],
    );
  }

  /// `Preparation is key!`
  String get HP_Carousel_Bonus_AdvicesDescr {
    return Intl.message(
      'Preparation is key!',
      name: 'HP_Carousel_Bonus_AdvicesDescr',
      desc: '',
      args: [],
    );
  }

  /// `Play games`
  String get HP_Carousel_Games {
    return Intl.message(
      'Play games',
      name: 'HP_Carousel_Games',
      desc: '',
      args: [],
    );
  }

  /// `Games`
  String get HP_Carousel_Games_GamesTitle {
    return Intl.message(
      'Games',
      name: 'HP_Carousel_Games_GamesTitle',
      desc: '',
      args: [],
    );
  }

  /// `Redeem your rewards!`
  String get HP_Carousel_Games_GamesDescr {
    return Intl.message(
      'Redeem your rewards!',
      name: 'HP_Carousel_Games_GamesDescr',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get Profile_PageTitle {
    return Intl.message(
      'Profile',
      name: 'Profile_PageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Current score:`
  String get Profile_Points_label {
    return Intl.message(
      'Current score:',
      name: 'Profile_Points_label',
      desc: '',
      args: [],
    );
  }

  /// `Your programs:`
  String get Profile_Programs_label {
    return Intl.message(
      'Your programs:',
      name: 'Profile_Programs_label',
      desc: '',
      args: [],
    );
  }

  /// `Debug:`
  String get Profile_Debug_label {
    return Intl.message(
      'Debug:',
      name: 'Profile_Debug_label',
      desc: '',
      args: [],
    );
  }

  /// `Add 500`
  String get Profile_Debug_addPointsButtonlabel {
    return Intl.message(
      'Add 500',
      name: 'Profile_Debug_addPointsButtonlabel',
      desc: '',
      args: [],
    );
  }

  /// `Credits`
  String get Profile_Credits_label {
    return Intl.message(
      'Credits',
      name: 'Profile_Credits_label',
      desc: '',
      args: [],
    );
  }

  /// `Task Timer`
  String get Countdown_PageTitle {
    return Intl.message(
      'Task Timer',
      name: 'Countdown_PageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Set a timer for a task!`
  String get Countdown_PageIntroText {
    return Intl.message(
      'Set a timer for a task!',
      name: 'Countdown_PageIntroText',
      desc: '',
      args: [],
    );
  }

  /// `Set a timer`
  String get Countdown_SetTimerButtonLabel {
    return Intl.message(
      'Set a timer',
      name: 'Countdown_SetTimerButtonLabel',
      desc: '',
      args: [],
    );
  }

  /// `Bonus Tasks`
  String get Bonus_PageTitle {
    return Intl.message(
      'Bonus Tasks',
      name: 'Bonus_PageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Earn bonus points with these tasks`
  String get Bonus_PageIntroText {
    return Intl.message(
      'Earn bonus points with these tasks',
      name: 'Bonus_PageIntroText',
      desc: '',
      args: [],
    );
  }

  /// `make your bed`
  String get Bonus_Task1_title {
    return Intl.message(
      'make your bed',
      name: 'Bonus_Task1_title',
      desc: '',
      args: [],
    );
  }

  /// `set the table`
  String get Bonus_Task2_title {
    return Intl.message(
      'set the table',
      name: 'Bonus_Task2_title',
      desc: '',
      args: [],
    );
  }

  /// `put your books away`
  String get Bonus_Task3_title {
    return Intl.message(
      'put your books away',
      name: 'Bonus_Task3_title',
      desc: '',
      args: [],
    );
  }

  /// `take care of dirty clothes`
  String get Bonus_Task4_title {
    return Intl.message(
      'take care of dirty clothes',
      name: 'Bonus_Task4_title',
      desc: '',
      args: [],
    );
  }

  /// `put away clean clothes`
  String get Bonus_Task5_title {
    return Intl.message(
      'put away clean clothes',
      name: 'Bonus_Task5_title',
      desc: '',
      args: [],
    );
  }

  /// `throw the trash away`
  String get Bonus_Task6_title {
    return Intl.message(
      'throw the trash away',
      name: 'Bonus_Task6_title',
      desc: '',
      args: [],
    );
  }

  /// `put your toys away`
  String get Bonus_Task7_title {
    return Intl.message(
      'put your toys away',
      name: 'Bonus_Task7_title',
      desc: '',
      args: [],
    );
  }

  /// `Planning advices`
  String get Advices_PageTitle {
    return Intl.message(
      'Planning advices',
      name: 'Advices_PageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Dress up`
  String get ProgramStepDressUp {
    return Intl.message(
      'Dress up',
      name: 'ProgramStepDressUp',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en', countryCode: 'US'),
      Locale.fromSubtags(languageCode: 'fr', countryCode: 'FR'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}