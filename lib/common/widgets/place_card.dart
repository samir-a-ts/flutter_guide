import 'package:flutter/material.dart';
import 'package:flutter_guide/api/data/places_list/place.dart';
import 'package:flutter_guide/assets/themes/theme.dart';
import 'package:flutter_guide/features/places_list/screens/places_list/places_list_page.dart';

/// Card widget with data about
/// particular [Place].
class PlaceCard extends StatelessWidget {
  /// Place, which data
  /// will be shown at the card.
  final Place place;

  /// Constructor for [PlaceCard].
  const PlaceCard({
    required this.place,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 188,
        width: double.infinity,
        color: AppTheme.of(context).additionalColor,
        child: Column(
          children: [
            Expanded(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      place.images.isEmpty ? '' : place.images.first,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      place.placeType.translate(context).toLowerCase(),
                      style:
                          ThemeHelper.textTheme(context).labelMedium!.copyWith(
                                fontWeight: FontWeight.w700,
                                color: Theme.of(context).backgroundColor,
                              ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: RichText(
                    maxLines: 3,
                    overflow: TextOverflow.fade,
                    text: TextSpan(
                      text: '${place.name}\n',
                      style:
                          ThemeHelper.textTheme(context).bodyMedium!.copyWith(
                                fontWeight: FontWeight.w500,
                                color: ThemeHelper.secondaryColor(context),
                              ),
                      children: [
                        TextSpan(
                          text: place.description,
                          style: ThemeHelper.textTheme(context)
                              .labelMedium!
                              .copyWith(
                                color: AppTheme.of(context).thirdColor,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
