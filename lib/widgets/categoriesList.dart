import 'package:flutter/material.dart';
import 'package:tuma/widgets/categoryCard.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          CategoryCard(
              title: "Carpentry",
              image:
                  "https://media.istockphoto.com/photos/young-woman-working-as-a-carpenter-picture-id1202485960?k=20&m=1202485960&s=612x612&w=0&h=tb-SJoh1z1EbapOLaJOnewAdgXaJbW_UPvqRRFwxcNI=",
              onTap: () {}),
          CategoryCard(
              title: "Plumbing",
              image:
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSY4Rdos-pZtnuvpVk7aJm2cnV-qnHLTJ6UzA&usqp=CAU",
              onTap: () {}),
          CategoryCard(
              title: "Beauty",
              image:
                  "https://media.istockphoto.com/photos/hair-stylist-in-brazil-picture-id1321545990?b=1&k=20&m=1321545990&s=170667a&w=0&h=qqy04nUCXKoyTT4t3DrWPwo4311hPY42Ki3v6CujbyA=",
              onTap: () {}),
          CategoryCard(
              title: "Delivery Services",
              image:
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRZRx6kXMMm4fkfTPJ88KkQrMwW1d-GZxmFeG6pbcROF3KyV1t_SSKB_VjeCaS1axF-o0o&usqp=CAU",
              onTap: () {}),
          CategoryCard(
            title: "Photography",
            image:
                "https://media.istockphoto.com/photos/portrait-of-beard-african-american-professional-cameraman-with-in-picture-id1312002976?k=20&m=1312002976&s=612x612&w=0&h=41ZiK0n4K6ivon-fVjRJ-trUPCmuXgI8gBpFx94yfV8=",
            onTap: () {},
            selected: false,
          ),
        ],
      ),
    );
  }
}
