import 'package:event_app/gen/assets.gen.dart';
import 'package:event_app/utils/navigation/app_route_names.dart';
import 'package:flutter/material.dart';

class AppUtils {
  factory AppUtils() => _singleton;

  AppUtils._internal();

  static final AppUtils _singleton = AppUtils._internal();

  List<String> specialityListEn = [
    'Dermatologist',
    'Surgeon',
    'Plastic Surgeon',
    'Other',
  ];

  List<String> specialityListAr = [
    'أخصائي جلدية',
    'جراح',
    'جراح تجميل',
    'أخرى',
  ];

  List<String> countriesEn = [
    'United Arab Emirates',
    'Saudi Arabia',
    'Egypt',
    'India',
    'Spain',
    'United Kingdom',
    'United States',
    'Pakistan',
  ];

  List<String> countriesAr = [
    'الإمارات العربية المتحدة',
    'المملكة العربية السعودية',
    'مصر',
    'الهند',
    'إسبانيا',
    'المملكة المتحدة',
    'الولايات المتحدة',
    'باكستان',
  ];

  List<HomeViewModel> homeViewModelList = [
    HomeViewModel(
      title: 'Agenda',
      image: Assets.images.agenda.path,
      iconData: Icons.calendar_month_outlined,
      color: Colors.blue.shade300,
      titleAr: 'جدول الأعمال',
      route: AppRouteNames().agendaRoute,
    ),
    HomeViewModel(
      title: 'Speakers',
      image: Assets.images.speakers.path,
      iconData: Icons.person,
      color: const Color(0xffadd1ee),
      titleAr: 'مكبرات الصوت',
      route: AppRouteNames().speakerListingRoute,
    ),
    HomeViewModel(
      title: 'Badge',
      image: Assets.images.badge.path,
      iconData: Icons.qr_code,
      color: const Color(0xff456e8f),
      titleAr: 'شارة',
      route: AppRouteNames().badgeRoute,
    ),
    HomeViewModel(
      title: 'Venue',
      image: Assets.images.venue.path,
      iconData: Icons.location_on_outlined,
      color: Colors.blue.shade300,
      titleAr: 'مكان',
      route: '',
    ),
    HomeViewModel(
      title: 'Brand Innovation',
      image: Assets.images.brandInnovation.path,
      iconData: Icons.photo_library_outlined,
      color: const Color(0xffadd1ee),
      titleAr: 'ابتكار العلامة التجارية',
      route: '',
    ),
    HomeViewModel(
      title: 'Brand Videos',
      image: Assets.images.brandVideos.path,
      iconData: Icons.play_arrow_outlined,
      color: const Color(0xff456e8f),
      titleAr: 'فيديوهات العلامة التجارية',
      route: '',
    ),
    HomeViewModel(
      title: 'Ask Questions',
      image: Assets.images.askQuestions.path,
      iconData: Icons.question_mark_rounded,
      color: Colors.blue.shade300,
      titleAr: 'اطرح الأسئلة',
      route: '',
    ),
    HomeViewModel(
      title: 'Voting',
      image: Assets.images.voting.path,
      iconData: Icons.poll_outlined,
      color: const Color(0xffadd1ee),
      titleAr: 'التصويت',
      route: '',
    ),
    HomeViewModel(
      title: 'Social Media',
      image: Assets.images.socialMedia.path,
      iconData: Icons.mobile_friendly_rounded,
      color: const Color(0xff456e8f),
      titleAr: 'وسائل التواصل الاجتماعي',
      route: '',
    ),
    HomeViewModel(
      title: 'Survey',
      image: Assets.images.survey.path,
      iconData: Icons.summarize_outlined,
      color: Colors.blue.shade300,
      titleAr: 'استطلاع',
      route: '',
    ),
    HomeViewModel(
      title: 'CME',
      image: Assets.images.cme.path,
      iconData: Icons.cast_for_education_rounded,
      color: const Color(0xffadd1ee),
      titleAr: 'التعليم الطبي المستمر',
      route: '',
    ),
    HomeViewModel(
      title: 'More',
      image: Assets.images.more.path,
      iconData: Icons.more_vert,
      color: const Color(0xff456e8f),
      titleAr: 'أكثر',
      route: '',
    ),
  ];
}

class HomeViewModel {
  HomeViewModel({
    required this.title,
    required this.titleAr,
    required this.image,
    required this.iconData,
    required this.color,
    required this.route,
  });

  final String title;
  final String titleAr;
  final String image;
  final IconData iconData;
  final Color color;
  final String route;
}
