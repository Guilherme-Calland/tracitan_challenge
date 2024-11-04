
import 'package:flutter/material.dart';

BuildContext? get globalContext => GlobalKey<NavigatorState>(debugLabel: 'root').currentContext;