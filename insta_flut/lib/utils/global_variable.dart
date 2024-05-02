import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insta_flut/screens/add_post_screen.dart';
import 'package:insta_flut/screens/feed_screen.dart';
import 'package:insta_flut/screens/profile_screen.dart';
import 'package:insta_flut/screens/search_screen.dart';

const webScreenSize = 600;
List<Widget>homeScreenItems = [
  FeedScreen(),
  SearchScreen(),
  AddPostScreen(),
  Center(child: Text('notif')),
  ProfileScreen(uid: FirebaseAuth.instance.currentUser!.uid,),
];
