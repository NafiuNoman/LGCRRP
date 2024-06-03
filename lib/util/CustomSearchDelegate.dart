import 'package:flutter/material.dart';


// add this after appbar if needed to use delegate
// floatingActionButton: Builder(
//     builder: (ctx) => FloatingActionButton(
//           onPressed: () async {
//             await showSearch(
//                 context: context, delegate: CustomSearchDelegate());
//           },
//           child: Icon(Icons.search),
//         )),



class CustomSearchDelegate extends SearchDelegate<String> {
  // Dummy list
  final List<String> searchList = [
    "Apple",
    "Banana",
    "Cherry",
    "Date",
    "Fig",
    "Grapes",
    "Kiwi",
    "Lemon",
    "Mango",
    "Orange",
    "Papaya",
    "Raspberry",
    "Strawberry",
    "Tomato",
    "Watermelon",
  ];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.ac_unit)),
    ];
    // TODO: implement buildActions
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Icon(Icons.arrow_back_ios_new_outlined));
    // TODO: implement buildLeading
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> searchResult = searchList
        .where((item) => item.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
        itemBuilder: (ctx, index) => ListTile(
              title: Text(searchResult[index]),
            ));
    // TODO: implement buildResults
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    final List<String> suggestionList = query.isEmpty
        ? []
        : searchList
        .where((item) => item.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestionList[index]),
          onTap: () {
            query = suggestionList[index];
            // Show the search results based on the selected suggestion.
          },
        );
      },
    );
    // TODO: implement buildSuggestions
  }
}
