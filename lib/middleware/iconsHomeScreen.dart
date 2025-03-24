import 'package:flutter/material.dart';

IconData getIconForArea(String area) {
  switch (area.toLowerCase()) {
    case 'TEA':
      return Icons.psychology;
    case 'Deficiencias':
      return Icons.diversity_3;
    case 'Praticas':
      return Icons.class_;
    case 'Síndrome de Down':
      return Icons.accessibility;
    case 'TDAH':
      return Icons.tips_and_updates;
    case 'Inclusão':
      return Icons.group;
    case 'ABA':
      return Icons.science;
    case 'SRM':
      return Icons.meeting_room;
    case 'Familia':
      return Icons.family_restroom;
    case 'Politicas Publicas':
      return Icons.policy;
    case 'AEE':
      return Icons.support;
    default:
      return Icons.question_mark;
  }
}
