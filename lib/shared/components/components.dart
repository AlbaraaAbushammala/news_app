import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/mooduls/web_view/web_view_screen.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  required Function() function,
  required String? text,
  bool isUpperCase = true,
  double radius = 0,
}) =>
    Container(
      width: width,
      child: MaterialButton(
        onPressed: function,
        height: 40,
        child: Text(
          isUpperCase ? text!.toUpperCase() : text!,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: background,
      ),
    );

Widget defaultFormField({
  required TextEditingController? controller,
  required TextInputType? type,
  Function? onSubmit,
  Function? onTap,
  Function? onChange,
  final Function? validate,
  required String label,
  required IconData prefixIcon,
  IconData? sufixIcon,
  bool obscureText = false,
  Function? sufixpressed,
  bool isClickble = true,
}) =>
    TextFormField(
      onChanged: (s) {
        onChange!(s);
      },
      controller: controller!,
      obscureText: obscureText,
      keyboardType: type!,
      validator: (s) {
        validate!(s);
      },
      onTap: () {
        onTap;
      },
      enabled: isClickble,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        prefixIcon: Icon(
          prefixIcon,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            sufixIcon,
          ),
          onPressed: () {
            sufixpressed!();
          },
        ),
      ),
    );

Widget myDriver() => Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );

Widget buildArticleItem(article, context) => InkWell(
      onTap: () {
        navigateTo(context, WebViewScreen(article["url"]));
      },
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage == null
                      ? NetworkImage(
                          "https://media.istockphoto.com/photos/neon-glowing-cross-shape-frame-stock-image-picture-id1288697507?b=1&k=20&m=1288697507&s=170667a&w=0&h=J2Cy8hyLtYZYSCbyBL5tVV4EzRDtKDuQoJ9S_dxiv-M=")
                      : NetworkImage("${article["urlToImage"]}"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Container(
                height: 120,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        "${article["title"]}",
                        style: Theme.of(context).textTheme.bodyText1,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      "${article["publishedAt"]}",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

Widget articleBuilder(list, context, {isSearch = false}) => ConditionalBuilder(
      condition: list.length > 0,
      builder: (context) => ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) => buildArticleItem(list[index], context),
        separatorBuilder: (context, index) => myDriver(),
        itemCount: list.length,
      ),
      fallback: (context) => isSearch ? Container() : Center(child: CircularProgressIndicator()),
    );

void navigateTo(context, widget) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (BuildContext context) => widget),
  );
}
