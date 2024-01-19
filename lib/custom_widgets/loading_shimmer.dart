import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingShimmer extends StatelessWidget {
  const LoadingShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.white,
              radius: 25,
            ),
            title: Container(
              height: 16,
              color: Colors.white,
            ),
            subtitle: Container(
              height: 12,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}

class LoadingCard extends StatelessWidget {
  const LoadingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Card(
        elevation: 5,
        child: ListTile(
          leading: const CircleAvatar(
            backgroundColor: Colors.white,
            radius: 25,
          ),
          title: Container(
            height: 16,
            width: 150,
            color: Colors.white,
          ),
          subtitle: Container(
            height: 12,
            width: 100,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
