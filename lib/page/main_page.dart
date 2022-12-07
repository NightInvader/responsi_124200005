import 'package:flutter/material.dart';
import 'package:resp/base_network.dart';
import 'package:resp/matches_model.dart';
import 'package:resp/matches_data_source.dart';
import 'package:resp/page/open_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("World Cup"),
      ),
      body: _buildMatchesBody(),
    );
  }
  Widget _buildMatchesBody() {
    return Scaffold(
      body: FutureBuilder(
        future: BaseNetwork.getList('matches'),
        builder: (
            BuildContext context,
            AsyncSnapshot<dynamic> snapshot,
            ) {
          if (snapshot.hasError) {
            print(snapshot);
            return _buildErrorSection();
          }
          if (snapshot.hasData) {
            return _buildSuccessSection(snapshot.data);
          }
          return _buildLoadingSection();
        },
      ),
    );
  }

  Widget _buildErrorSection() {
    return Text("Error");
  }

  // Widget _buildEmptySection() {
  //   return Text("Empty");
  // }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSuccessSection(List<dynamic> matches) {
    return Stack(
      children: [
        ListView.builder(
          itemCount: 48,
          itemBuilder: (BuildContext context, int index) {
            MatchesModel matchesModel = MatchesModel.fromJson(matches[index]);
            // final String? Match = matchesModel.id;
            return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OpenPage(matchId:matchesModel.id.toString() )));
              },
              child: Container(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 5, right: 5),
                        child: itemCard(matchesModel),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget itemCard(MatchesModel matches) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 2,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Image.network("https://countryflagsapi.com/png/${matches.homeTeam?.name}", width: 170, height: 150,),
                        Text("${matches.homeTeam?.name}")
                      ],
                    ),
                    Text(" ${matches.homeTeam?.goals}"),
                    Text(" - "),
                    Text("${matches.awayTeam?.goals} "),
                    Column(
                      children: [
                        Image.network("https://countryflagsapi.com/png/${matches.awayTeam?.name}", width: 170, height: 150,),
                        Text("${matches.awayTeam?.name}")
                      ],
                    ),
                  ],
                ),
                  // child: ListTile(
                  //   leading: Column(
                  //     children: [
                  //       Image.network(
                  //         "https://countryflagsapi.com/png/${matches.homeTeam?.name}",
                  //         height: 50,
                  //       ),
                  //       SizedBox(
                  //         height: 3,
                  //       ),
                  //       Text(
                  //         '${matches.homeTeam?.name}',
                  //         textAlign: TextAlign.center,
                  //       ),
                  //     ],
                  //   ),
                  //   title: Text(
                  //     "${matches.homeTeam?.goals} : ${matches.awayTeam?.goals}",
                  //     textAlign: TextAlign.center,
                  //     style: TextStyle(fontSize: 14.0),
                  //   ),
                  //   trailing: Column(
                  //     children: [
                  //       Image.network(
                  //         "https://countryflagsapi.com/png/${matches.awayTeam?.name}",
                  //         height: 37,
                  //       ),
                  //       SizedBox(
                  //         height: 3,
                  //       ),
                  //       Text(
                  //         '${matches.awayTeam?.name}',
                  //         textAlign: TextAlign.center,
                  //       ),
                  //     ],
                  //   ),
                  // )
              ),
            ],
          )),
    );
  }
}
//   Widget _matchesBody(){
//     return Container(
//       child: Container(
//         child: FutureBuilder(
//           future: BaseNetwork.getList('matches'),
//           builder: (
//               BuildContext context,
//               AsyncSnapshot<dynamic> snapshot,
//               ) {
//             if (snapshot.hasError) {
//               print(snapshot);
//               return _buildErrorSections();
//             }
//             if (snapshot.hasData) {
//               MatchesModel match =
//               MatchesModel.fromJson(snapshot.data);
//               return _buildSuccessSection(match);
//             }
//             return _buildLoadingSection();
//           },
//         ),
//       ),,
//     );
//   }
//   Widget _buildErrorSections(){
//     return Text("Error");
//   }
//   Widget _buildLoadingSection() {
//     return Center(
//       child: CircularProgressIndicator(),
//     );
//   }
//   Widget _buildSuccessSection(MatchesModel data) {
//     return ListView.builder(
//       itemCount: 48,
//       itemBuilder: (BuildContext context, int index) {
//         final String? match = data?.id;
//         return _matchCard(match,data);
//       },
//     );
//   }
//   Widget _matchCard(String? match, MatchesModel data) {
//     return InkWell(
//       onTap: (){
//         Navigator.push(context, MaterialPageRoute(builder: (context){
//           return OpenPage(match : match);
//         }));
//       },
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//         child: Card(
//         shape: ContinuousRectangleBorder(
//           borderRadius:BorderRadius.circular(10)
//         ),
//           child: Row(
//             children: [
//               Column(
//                 children: [
//                   Image.network("https://countryflagsapi.com/png/${data?.homeTeam?.name}"),
//                   Text("${data?.homeTeam?.name}")
//                 ],
//               ),
//               Text("${data?.homeTeam?.goals}"),
//               Text("${data?.awayTeam?.goals}"),
//               Column(
//                 children: [
//                   Image.network("https://countryflagsapi.com/png/${data?.awayTeam?.name}"),
//                   Text("${data?.awayTeam?.name}")
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
