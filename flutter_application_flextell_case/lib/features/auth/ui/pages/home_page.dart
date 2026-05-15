import 'package:flutter/material.dart';
import 'package:flutter_application_flextell_case/features/auth/bloc/Home_Bloc/home_bloc.dart';
import 'package:flutter_application_flextell_case/features/auth/bloc/Home_Bloc/home_state.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final scale = width / 375;

    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomePageLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is HomePageError) {
            return Center(child: Text(state.message));
          }

          if (state is HomePageLoaded) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // TOKEN SECTION
                  Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSection(
                          title: 'ACCESS TOKEN',
                          value: state.token!.accessToken.substring(0, 20),
                        ),

                        SizedBox(height: 10 * scale),

                        _buildSection(
                          title: 'REFRESH TOKEN',
                          value: state.token!.refreshToken.substring(0, 20),
                        ),

                        SizedBox(height: 10 * scale),

                        _buildSection(
                          title: 'EXPIRES',
                          value: state.token!.expiresAt.toString(),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20 * scale),

                  // CUSTOMERS LIST
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: state.customers.length,
                    itemBuilder: (context, index) {
                      final customer = state.customers[index];

                      return Card(
                        elevation: 3,
                        margin: EdgeInsets.only(bottom: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Text(customer.firstName.isNotEmpty
                              ? customer.firstName[0]
                              : "?"
                            ),
                          ),
                          title: Text('${customer.firstName} ${customer.lastName}'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Contact Information:"),
                              SizedBox(height: 10 * scale,),
                              Text(customer.phone),
                              Text(customer.email),
                              SizedBox(height: 10 * scale,),
                              Text("Address:"),
                              Text(customer.city),
                              Text(customer.country),
                              Text(customer.address),
                            ],
                          )
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          }

          return SizedBox();
        },
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required String value,
    bool showCopy = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),

        SizedBox(height: 6),

        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  value,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontFamily: "monospace", fontSize: 13),
                ),
              ),

              if (showCopy)
                IconButton(
                  icon: Icon(Icons.copy, size: 18),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: value));

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("$title copied"),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                ),
            ],
          ),
        ),
      ],
    );
  }
}
