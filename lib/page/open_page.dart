

import 'package:resp/detail_matches_model.dart';
import 'package:resp/matches_model.dart';
import 'package:flutter/material.dart';
import 'package:resp/matches_model.dart';
import 'package:resp/page/open_page.dart';
import 'package:resp/base_network.dart';

class OpenPage extends StatefulWidget {
  final String matchId;
  const OpenPage({Key? key, required this.matchId}) : super(key: key);

  @override
  State<OpenPage> createState() => _OpenPageState();
}

class _OpenPageState extends State<OpenPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Match"),
      ),
      body:ListView(
        children: [
          FutureBuilder(
              future: BaseNetwork.get("matches/${widget.matchId}"),
              builder:
                  (BuildContext context, AsyncSnapshot<dynamic> snapshot)
              {
                if(snapshot.hasError){
                  return _buildErrorSection();
                }if(snapshot.hasData){
                  DetailMatchesModel detailModels = DetailMatchesModel.fromJson(snapshot.data);
                  return _buildSuccessSection(detailModels);
                }
                return _buildLoadingSection();
              },
          )
        ],
      ) ,
    //   child: ListView(
    //     children: [
    //       Row(
    //         children: [
    //           Column(
    //             children: [
    //               Image.network(src),
    //               Text(data),
    //             ],
    //           ),
    //           Text(data),
    //           Text(data),
    //           Column(
    //             children: [
    //               Image.network(src),
    //               Text(data),
    //             ],
    //           ),
    //         ],
    //       )
    //     ],
    //   )
    );
  }
  Widget _buildErrorSection(){
    return Text("Error masze");
  }
  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
  Widget _buildSuccessSection(DetailMatchesModel match){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Column(
                children: [
                  Image.network("https://countryflagsapi.com/png/${match.homeTeam?.name}"),
                  Text("${match.homeTeam?.name}"),
                ],
              ),
            ),
            Text("${match.homeTeam?.goals}"),
            Text("${match.awayTeam?.goals}"),
            Container(
              child: Column(
                children: [
                  Image.network("https://countryflagsapi.com/png/${match.awayTeam?.name}"),
                  Text("${match.awayTeam?.name}"),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 300,
        ),
        Column(
          children: [
            Text("${match.venue}"),
            Text("${match.location}"),
          ],
        ),

        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 2
            )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Statistic"),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  Text("${match.homeTeam?.statistics?.ballPossession}"),

                  Text("Ball Possession"),
                  Text("${match.awayTeam?.statistics?.ballPossession}")
                ],
              ),
              Row(
                children: [
                  Text("${match.homeTeam?.statistics?.attemptsOnGoal}"),
                  Text("Shot"),
                  Text("${match.awayTeam?.statistics?.attemptsOnGoal}")
                ],
              ),
              Row(
                children: [
                  Text("${match.homeTeam?.statistics?.kicksOnTarget}"),
                  Text("Shot on Target"),
                  Text("${match.awayTeam?.statistics?.kicksOnTarget}")
                ],
              ),
              Row(
                children: [
                  Text("${match.homeTeam?.statistics?.corners}"),
                  Text("Corners"),
                  Text("${match.awayTeam?.statistics?.corners}")
                ],
              ),
              Row(
                children: [
                  Text("${match.homeTeam?.statistics?.offsides}"),
                  Text("OffSides"),
                  Text("${match.awayTeam?.statistics?.offsides}")
                ],
              ),
              Row(
                children: [
                  Text("${match.homeTeam?.statistics?.foulsCommited}"),
                  Text("Fouls"),
                  Text("${match.awayTeam?.statistics?.foulsCommited}")
                ],
              ),
              Row(
                children: [
                  Text("${match.homeTeam?.statistics?.passes}"),
                  Text("Pass Accuracy"),
                  Text("${match.awayTeam?.statistics?.passes}")
                ],
              ),
            ],
          ),
        ),
        Text("Referee"),
        Container(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
              itemCount: match.officials?.length,
              itemBuilder: (context, index)
              {
                return Container(
                  height: 200,
                  width: 100,
                  margin: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("FIFA",
                        style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      ),
                      Flexible(
                          child:Text("${match.officials?[index].name}")
                      ),
                      Flexible(
                          child:Text("${match.officials?[index].role}")
                      ),
                    ],
                  ),
                );
              }
              ),
        ),
      ],
    );
  }
}
