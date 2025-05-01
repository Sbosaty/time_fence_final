import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:svg_flutter/svg.dart';
import 'package:time_fence/bloc/app_cubit.dart';
import 'package:time_fence/bloc/app_state.dart';
import 'package:time_fence/unit/source.dart';


class EmployeeIDCard extends StatelessWidget {
  const EmployeeIDCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit,AppState>(
        builder: (context,state){
          var cubit = AppCubit.get(context);
      return Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: ColorSource.whiteColor,
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const CircleAvatar(
                radius: 40,
                child: Icon(FontAwesomeIcons.user,size: 25,),
                // Replace with your asset
              ),
              const SizedBox(height: 10),
              Text(
                (cubit.userModel?.name??"").toUpperCase(),
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                cubit.userModel?.jopTitle??'',
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
              const Divider(height: 30, color: Colors.black),
              InfoRow(label: 'Email : ', value: cubit.userModel?.email??''),
              InfoRow(label: 'Name :', value: cubit.userModel?.name??''),
              InfoRow(label: 'Phone :', value: cubit.userModel?.phone??''),

            ],
          ),
        ),
      );
    });
  }
}

class InfoRow extends StatelessWidget {
  final String label;
  final String value;

  InfoRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.w600)),
          Text(value),
        ],
      ),
    );
  }
}