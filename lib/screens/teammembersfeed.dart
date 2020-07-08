import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/api/teammembers_api.dart';
import 'package:flash_chat/model/teammembers.dart';
import 'package:flash_chat/notifier/teammember_notifier.dart';
import 'package:flash_chat/screens/member_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TeamMembersFeed extends StatefulWidget {
  @override
  _TeamMembersFeedState createState() => _TeamMembersFeedState();
}

class _TeamMembersFeedState extends State<TeamMembersFeed> {
  final _auth = FirebaseAuth.instance;
  @override
  void initState() {
    TeamMemberNotifier teamMemberNotifier =
        Provider.of<TeamMemberNotifier>(context, listen: false);
    getTeamMembers(teamMemberNotifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
//    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context);
//    FoodNotifier foodNotifier = Provider.of<FoodNotifier>(context);
    TeamMemberNotifier teamMemberNotifier =
        Provider.of<TeamMemberNotifier>(context);

    Future<void> _refreshList() async {
      getTeamMembers(teamMemberNotifier);
    }

    print("building Feed");
    return Scaffold(
      appBar: AppBar(
        title: Text('Future Readiness'),
        actions: <Widget>[
          // search button
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(
                    context: context, delegate: DataSearch(teamMemberNotifier));
              }),
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
              }),
          // action button
//          FlatButton(
////            onPressed: () => signout(authNotifier),
//            onPressed: () {},
//            child: Text(
//              "Logout",
//              style: TextStyle(fontSize: 18, color: Colors.white),
//            ),
//          ),
        ],
      ),
      body: new RefreshIndicator(
        child: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
//              leading: Image.network(
//                teamMemberNotifier.teammemberlist[index].readiness
//                    ? Icon
//                    : 'https://www.testingxperts.com/wp-content/uploads/2019/02/placeholder-img.jpg',
//                width: 120,
//                fit: BoxFit.fitWidth,
//              ),
              title: teamMemberNotifier.teammemberlist[index].lastname != null
                  ? Text(
                      teamMemberNotifier.teammemberlist[index].firstname
                              .toString() +
                          ' ' +
                          teamMemberNotifier.teammemberlist[index].lastname,
                      style: TextStyle(
                          color: Color(0xFF2A2969),
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    )
                  : Text(
                      teamMemberNotifier.teammemberlist[index].firstname
                          .toString(),
                      style: TextStyle(
                          color: Color(0xFF2A2969),
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
              trailing:
                  (teamMemberNotifier.teammemberlist[index].readiness == 'yes')
                      ? Icon(Icons.check_circle_outline,
                          size: 40, color: Colors.greenAccent)
                      : Icon(Icons.block, size: 40, color: Colors.redAccent),
              subtitle: Text(teamMemberNotifier.teammemberlist[index].futrole +
                  ' in ' +
                  teamMemberNotifier.teammemberlist[index].tower),
              onTap: () {
                teamMemberNotifier.currentteammember =
                    teamMemberNotifier.teammemberlist[index];
                print(teamMemberNotifier.currentteammember.firstname);
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) {
                    return TeamMemberDetail();
                  }),
                );
              },
            );
          },
          itemCount: teamMemberNotifier.teammemberlist.length,
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              color: Color(0xFFFBAB19),
              thickness: 1,
            );
          },
        ),
        onRefresh: _refreshList,
      ),
//      floatingActionButton: FloatingActionButton(
//        onPressed: () {
//          foodNotifier.currentFood = null;
//          Navigator.of(context).push(
//            MaterialPageRoute(builder: (BuildContext context) {
//              return FoodForm(
//                isUpdating: false,
//              );
//            }),
//          );
//        },
//        child: Icon(Icons.add),
//        foregroundColor: Colors.white,
//      ),
    );
  }
}

class DataSearch extends SearchDelegate<String> {
//  AuthNotifier authNotifier;
  TeamMemberNotifier teamMemberNotifier;
  DataSearch(this.teamMemberNotifier);
//  List<String> whatever = ['A', 'B', 'C'];
//
  Future<void> _refreshList() async {
    getTeamMembers(teamMemberNotifier);
  }

//
  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

//
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () {
          close(context, null);
        });
  }

//
  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return null;
  }

//
  @override
  Widget buildSuggestions(BuildContext context) {
    List<TeamMember> suggestionList = query.isEmpty
        ? teamMemberNotifier.teammemberlist
        : teamMemberNotifier.teammemberlist
            .where((p) =>
                p.firstname.toLowerCase().startsWith(query.toLowerCase()) ||
                p.tower.toLowerCase().startsWith(query.toLowerCase()))
            .toList();
//    // TODO: implement buildSuggestions
    return RefreshIndicator(
      child: ListView.separated(
//      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ListTile(
//              leading: Image.network(
//                teamMemberNotifier.teammemberlist[index].readiness
//                    ? Icon
//                    : 'https://www.testingxperts.com/wp-content/uploads/2019/02/placeholder-img.jpg',
//                width: 120,
//                fit: BoxFit.fitWidth,
//              ),
              title: suggestionList[index].lastname != null
                  ? Text(
                      suggestionList[index].firstname +
                          ' ' +
                          '${suggestionList[index].lastname}',
                      style: TextStyle(
                          color: Color(0xFF2A2969),
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    )
                  : Text(
                      suggestionList[index].firstname,
                      style: TextStyle(
                          color: Color(0xFF2A2969),
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
              trailing: (suggestionList[index].readiness == 'yes')
                  ? Icon(Icons.check_circle_outline,
                      size: 40, color: Colors.greenAccent)
                  : Icon(Icons.block, size: 40, color: Colors.redAccent),
              subtitle: Text(suggestionList[index].futrole ??= 'Unspecified'),
              onTap: () {
                teamMemberNotifier.currentteammember = suggestionList[index];
                print(teamMemberNotifier.currentteammember.firstname);
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) {
                    return TeamMemberDetail();
                  }),
                );
              },
            ),
          );
        },
        itemCount: suggestionList.length,
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            color: Color(0xFFFBAB19),
            thickness: 1,
          );
        },
      ),
      onRefresh: _refreshList,
    );
  }
}
