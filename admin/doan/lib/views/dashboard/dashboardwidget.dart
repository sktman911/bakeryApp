import 'package:flutter/material.dart';
import './dashboardbody.dart';

class Dashboardwidget extends StatefulWidget {
  const Dashboardwidget({Key? key}) : super(key: key);

  @override
  _DashboardwidgetState createState() => _DashboardwidgetState();
}

class _DashboardwidgetState extends State<Dashboardwidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Dashboard"),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(children: [
              const SizedBox(height: 16),
            const Text("Number of customer each year",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            const SizedBox(height: 16),
            Container(
                height: 300,
                 padding: EdgeInsets.all(16), child: FutureBuilder<Widget>(
                  future: BuildChart3(), builder: (BuildContext context, AsyncSnapshot<Widget> snapshot)
                  {
                     if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return snapshot.data ?? Container(); 
                    }
                  }
                )),
            const SizedBox(
              height: 16,
            ),

            const Text("Total order each month",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            const SizedBox(height: 16),
            Container(
                height: 300,
                 padding: EdgeInsets.all(16), child: 
                FutureBuilder<Widget>(
                  future: BuildChart(), builder: (BuildContext context, AsyncSnapshot<Widget> snapshot)
                  {
                     if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return snapshot.data ?? Container(); 
                    }
                  }
                )
                ),
            const SizedBox(
              height: 16,
            ),

            const Text("Total order each year",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            const SizedBox(
              height: 16,
            ),
            Container(
                height: 300, padding: EdgeInsets.all(16), child: FutureBuilder<Widget>(
                  future: BuildChart2(), builder: (BuildContext context, AsyncSnapshot<Widget> snapshot)
                  {
                     if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return snapshot.data ?? Container(); 
                    }
                  }
                )
              ),
            const SizedBox(height: 16),
          ])),
        ));
  }
}
