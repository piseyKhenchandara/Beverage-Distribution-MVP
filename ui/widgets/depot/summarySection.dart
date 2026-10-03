import 'package:flutter/material.dart';

class SummarySection extends StatelessWidget {
 
  final int total;
  final VoidCallback confirmOrder;

  SummarySection({required this.total, required this.confirmOrder});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          height: 40,
          margin: EdgeInsets.only(left: 8, right: 8),
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey,
          ),

          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total"),
                Container(
                  child: Row(
                    children: [
                      Text("${total.toString()}"),
                      SizedBox(width: 10),
                      Text("boxes"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 5),

        GestureDetector(
          onTap: confirmOrder,
          child: Container(
            height: 40,
            margin: EdgeInsets.only(left: 8, right: 8),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text("Confirm Order", style: TextStyle(color: Colors.white)),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
