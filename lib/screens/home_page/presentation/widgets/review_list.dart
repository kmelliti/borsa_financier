import 'package:borsa_now_bis/core/config/utils.dart';
import 'package:borsa_now_bis/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ReviewList extends StatelessWidget {
  const ReviewList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemCount: 2,
          itemBuilder: (context, index) => singleReview(context),
        ),
        SizedBox(height: 10),

        InkWell(
          onTap: () {},
          child: Text(
            "show_more".tr,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: HexColor.fromHex(AppTheme.primaryColor),
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
        SizedBox(height: 20),
        commentHolder(),

      ],
    );
  }

  Container singleReview(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: HexColor.fromHex(AppTheme.borderGrey)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcREO17hg6KvLlweeZWN0LCEdi-OXM9qGpbQ9w&s",
              ),
            ),
            title: Text("عبدالله_السعودي"),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [StarRating(rating: 4, size: 20)],
            ),
            trailing: Text(
              "منذ شهر",
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: HexColor.fromHex(AppTheme.darkGrey),
              ),
            ),
          ),
          SizedBox(height: 20),
          Text(
            "القهوة هنا لذيذة جدًا، أحببت النكهة الغنية والكراميل مع القهوة 😍",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: HexColor.fromHex('#1E1D33'),
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget commentHolder() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: HexColor.fromHex(AppTheme.borderGrey)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 200,
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "write_comment".tr,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
              ),
            ),
          ),
          Spacer(),
          InkWell(
            onTap: () {},
            child: SvgPicture.asset("assets/icons/attachement.svg"),
          ),

          SizedBox(width: 15),
          InkWell(
            onTap: () {},
            child: SvgPicture.asset("assets/icons/send.svg"),
          ),
        ],
      ),
    );
  }
}
