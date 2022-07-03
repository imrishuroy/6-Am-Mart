import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '/helpers/dimensions.dart';
import '/helpers/responsive_helper.dart';
import '/translations/locale_keys.g.dart';
import '/utils/utils.dart';

class PaginatedListView extends StatefulWidget {
  final ScrollController scrollController;
  final Function(int offset) onPaginate;
  final int totalSize;
  final int offset;
  final Widget itemView;
  const PaginatedListView({
    Key? key,
    required this.scrollController,
    required this.onPaginate,
    required this.totalSize,
    required this.offset,
    required this.itemView,
  }) : super(key: key);

  @override
  State<PaginatedListView> createState() => _PaginatedListViewState();
}

class _PaginatedListViewState extends State<PaginatedListView> {
  int _offset = 0;
  List<int> _offsetList = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    _offset = 1;
    _offsetList = [1];

    widget.scrollController.addListener(() {
      if (widget.scrollController.position.pixels ==
              widget.scrollController.position.maxScrollExtent &&
          !_isLoading) {
        if (mounted && !ResponsiveHelper.isDesktop(context)) {
          _paginate();
        }
      }
    });
  }

  void _paginate() async {
    // watch this
    int pageSize = (widget.totalSize).ceil();
    if (_offset < pageSize && !_offsetList.contains(_offset + 1)) {
      setState(() {
        _offset = _offset + 1;
        _offsetList.add(_offset);
        _isLoading = true;
      });
      await widget.onPaginate(_offset);
      setState(() {
        _isLoading = false;
      });
    } else {
      if (_isLoading) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _offset = widget.offset;
    _offsetList = [];
    for (int index = 1; index <= widget.offset; index++) {
      _offsetList.add(index);
    }

    return Column(children: [
      widget.itemView,
      (ResponsiveHelper.isDesktop(context) &&
              (_offset >= (widget.totalSize / 10).ceil() ||
                  _offsetList.contains(_offset + 1)))
          ? const SizedBox.shrink()
          : Center(
              child: Padding(
              padding: (_isLoading || ResponsiveHelper.isDesktop(context))
                  ? const EdgeInsets.all(Dimensions.paddingSizeSmall)
                  : EdgeInsets.zero,
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : (ResponsiveHelper.isDesktop(context))
                      ? InkWell(
                          onTap: _paginate,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: Dimensions.paddingSizeSmall,
                                horizontal: Dimensions.paddingSizeLarge),
                            margin: ResponsiveHelper.isDesktop(context)
                                ? const EdgeInsets.only(
                                    top: Dimensions.paddingSizeSmall)
                                : null,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radiusSmall),
                              color: Theme.of(context).primaryColor,
                            ),
                            child: Text(LocaleKeys.view_more.tr(),
                                style: robotoMedium.copyWith(
                                    fontSize: Dimensions.fontSizeLarge,
                                    color: Colors.white)),
                          ),
                        )
                      : const SizedBox.shrink(),
            )),
    ]);
  }
}
