import 'package:flutter/material.dart';
import 'package:lpi_app/utils/colors.dart';

class MemberItem extends StatelessWidget {
  const MemberItem({
    Key key,
    @required this.userData,
    this.onTap,
  }) : super(key: key);

  final userData;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.white,
                  width: 2,
                ),
                color: AppColors.white,
                borderRadius: BorderRadius.circular(100),
              ),
              child: ClipOval(
                child: (userData.data["downloadUrl"] != null)
                    ? Image.network(
                        userData.data["downloadUrl"],
                        fit: BoxFit.contain,
                      )
                    : Image.network(
                        'https://cdn.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png',
                        fit: BoxFit.contain,
                      ),
              ),
            ),
            SizedBox(width: 16.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${userData.data["firstname"]} ${userData.data["surname"]}",
                  style: TextStyle(color: Colors.white, fontSize: 15.0),
                ),
                SizedBox(height: 4.0),
                Text(
                  "${userData.data["email"]}",
                  style: TextStyle(color: Colors.white70),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
