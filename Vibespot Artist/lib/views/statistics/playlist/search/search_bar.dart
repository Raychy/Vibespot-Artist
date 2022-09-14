import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vsartist/constants/app_colors.dart';

import 'cubit/search_cubit.dart';

class SearchBar extends StatelessWidget {
  final Function()? onPressed;
  final SearchCubit? cubit;

  final FocusNode? focusNode;

  const SearchBar({Key? key, this.onPressed, this.cubit, this.focusNode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      color: Color(0xff3E3E3E),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
          child: Row(
            children: [
              Icon(CupertinoIcons.search, color: Color(0xffCFCDCD), size: 15),
              SizedBox(width: 20),
              Expanded(
                  child: AbsorbPointer(
                absorbing: cubit == null,
                child: TextFormField(
                  focusNode: focusNode,
                  cursorColor: AppColors.PRIMARY,
                  onChanged: cubit?.queryChanged,
                  decoration: InputDecoration(
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(),
                    isDense: true,
                    hintStyle: Theme.of(context)
                        .textTheme
                        .bodyText2
                        ?.copyWith(color: Colors.white30, fontSize: 12),
                    hintText: 'Search song',
                  ),
                ),
              )
                  //   Text(
                  // 'YouTube, Vibestream, Library & Soundcloud',
                  // style: Theme.of(context)
                  //     .textTheme
                  //     .bodyText2
                  //     ?.copyWith(color: Colors.white30, fontSize: 12),
                  )
            ],
          ),
        ),
      ),
    );
  }
}
