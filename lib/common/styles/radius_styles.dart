import 'package:colegio_bnnm/util/constants/enums.dart';
import 'package:colegio_bnnm/util/constants/sizes.dart';
import 'package:flutter/material.dart';

class BRadiusStyles {
  static const all =
      BorderRadius.all(Radius.circular(BSizes.borderRadiusContainerMd));
  static const upLg = BorderRadius.only(
      topLeft: Radius.circular(BSizes.borderRadiusContainerLg),
      topRight: Radius.circular(BSizes.borderRadiusContainerLg));
  static const upMg = BorderRadius.only(
      topLeft: Radius.circular(BSizes.borderRadiusContainerMd),
      topRight: Radius.circular(BSizes.borderRadiusContainerMd));
  static const down = BorderRadius.only(
      bottomLeft: Radius.circular(BSizes.borderRadiusContainerLg),
      bottomRight: Radius.circular(BSizes.borderRadiusContainerLg));

  static const diagonalTopLeftLarge = BorderRadius.only(
      topLeft: Radius.circular(BSizes.borderRadiusContainerLg),
      topRight: Radius.circular(BSizes.borderRadiusContainerMd),
      bottomLeft: Radius.circular(BSizes.borderRadiusContainerMd),
      bottomRight: Radius.circular(BSizes.borderRadiusContainerLg));
  static const diagonalBottomLeftLarge = BorderRadius.only(
      topLeft: Radius.circular(BSizes.borderRadiusContainerMd),
      topRight: Radius.circular(BSizes.borderRadiusContainerLg),
      bottomLeft: Radius.circular(BSizes.borderRadiusContainerLg),
      bottomRight: Radius.circular(BSizes.borderRadiusContainerMd));
  static const diagonalTopLeftMedium = BorderRadius.only(
      topLeft: Radius.circular(BSizes.borderRadiusContainerMd),
      topRight: Radius.circular(BSizes.sm),
      bottomLeft: Radius.circular(BSizes.sm),
      bottomRight: Radius.circular(BSizes.borderRadiusContainerMd));
  static const diagonalBottomLeftMedium = BorderRadius.only(
      //
      topLeft: Radius.circular(BSizes.sm),
      topRight: Radius.circular(BSizes.borderRadiusContainerMd),
      bottomLeft: Radius.circular(BSizes.borderRadiusContainerMd),
      bottomRight: Radius.circular(BSizes.sm));
  static const chatRightMedium = BorderRadius.only(
      topLeft: Radius.circular(BSizes.borderRadiusContainerMd),
      topRight: Radius.circular(BSizes.xs),
      bottomLeft: Radius.circular(BSizes.borderRadiusContainerMd),
      bottomRight: Radius.circular(BSizes.borderRadiusContainerMd));
  static const chatLeftMedium = BorderRadius.only(
      topLeft: Radius.circular(BSizes.xs),
      topRight: Radius.circular(BSizes.borderRadiusContainerMd),
      bottomLeft: Radius.circular(BSizes.borderRadiusContainerMd),
      bottomRight: Radius.circular(BSizes.borderRadiusContainerMd));
  static const chatRightLarge = BorderRadius.only(
      topLeft: Radius.circular(BSizes.borderRadiusContainerLg),
      topRight: Radius.circular(BSizes.borderRadiusLg),
      bottomLeft: Radius.circular(BSizes.borderRadiusContainerLg),
      bottomRight: Radius.circular(BSizes.borderRadiusContainerLg));
  static const chatLeftLarge = BorderRadius.only(
      topLeft: Radius.circular(BSizes.borderRadiusLg),
      topRight: Radius.circular(BSizes.borderRadiusContainerLg),
      bottomLeft: Radius.circular(BSizes.borderRadiusContainerLg),
      bottomRight: Radius.circular(BSizes.borderRadiusContainerLg));
  static const backChatLeftLarge = BorderRadius.only(
      topLeft: Radius.circular(BSizes.borderRadiusContainerLg),
      topRight: Radius.circular(BSizes.borderRadiusContainerLg),
      bottomLeft: Radius.circular(BSizes.borderRadiusSm),
      bottomRight: Radius.circular(BSizes.borderRadiusContainerLg));
  static const backChatRightLarge = BorderRadius.only(
    topLeft: Radius.circular(BSizes.borderRadiusContainerLg),
    topRight: Radius.circular(BSizes.borderRadiusContainerLg),
    bottomLeft: Radius.circular(BSizes.borderRadiusContainerLg),
    // bottomRight: Radius.circular(BSizes.borderRadiusMd),
  );
  static const backChatLeftMedium = BorderRadius.only(
      topLeft: Radius.circular(BSizes.borderRadiusContainerMd),
      topRight: Radius.circular(BSizes.borderRadiusContainerMd),
      bottomLeft: Radius.circular(BSizes.borderRadiusSm),
      bottomRight: Radius.circular(BSizes.borderRadiusContainerMd));
  static const backChatRightMedium = BorderRadius.only(
      topLeft: Radius.circular(BSizes.borderRadiusContainerMd),
      topRight: Radius.circular(BSizes.borderRadiusContainerMd),
      bottomLeft: Radius.circular(BSizes.borderRadiusContainerMd),
      bottomRight: Radius.circular(BSizes.borderRadiusSm));

  static const Map<Rounded, BorderRadius> radius = {
    Rounded.all: all,
    Rounded.upLg: upLg,
    Rounded.upMd: upMg,
    Rounded.down: down,
    Rounded.chatLLg: chatLeftLarge,
    Rounded.chatRLg: chatRightLarge,
    Rounded.chatLMd: chatLeftMedium,
    Rounded.chatRMd: chatRightMedium,
    Rounded.backChatLLg: backChatLeftLarge,
    Rounded.backChatRLg: backChatRightLarge,
    Rounded.backChatLMd: backChatLeftMedium,
    Rounded.backChatRMd: backChatRightMedium,
    Rounded.diagonalBottom: diagonalBottomLeftLarge,
    Rounded.diagonalTop: diagonalTopLeftLarge,
  };
}
