import 'package:flutter/material.dart';
import 'main.dart';
import 'mydrawer.dart';
import 'surah_builder.dart';
import 'constant.dart';
import 'package:ytquran/arabic_sura_number.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Go to bookmark',
        child: const Icon(Icons.bookmark,color: Colors.white,),
        backgroundColor: Colors.orange,
        onPressed: () async {
          fabIsClicked = true;
          if (await getBookmark() == true) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SurahBuilder(
                          arabic: quran[0],
                          sura: bookmarkedSura - 1,
                          suraName: arabicName[bookmarkedSura - 1]['name'],
                          ayah: bookmarkedAyah,

                        )));
          }
        },
      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          //"القرآن",
          "Quran",
          style: TextStyle(
              //fontFami     jhgjhly: 'quran',
              fontSize: 35,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: [
                Shadow(
                  offset: Offset(1, 1),
                  blurRadius: 2.0,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ]),
        ),
        backgroundColor: Colors.orange,
      ),
      body: FutureBuilder(
        future: readJson(),
        builder: (
          BuildContext context,
          AsyncSnapshot snapshot,
        ) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return const Text('Error');
            } else if (snapshot.hasData) {
              return indexCreator(snapshot.data, context);
            } else {
              return const Text('Empty data');
            }
          } else {
            return Text('State: ${snapshot.connectionState}');
          }
        },
      ),
    );
  }

  Container indexCreator(quran, context) {
    return Container(
      color: const Color.fromARGB(255, 221, 250, 236),
      child: Column(
        children: [
          MaterialButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>CalculatorScreen()));
          },child:Text(' search')),
          Expanded(
            child: ListView(
              children: [
                for (int i = 0; i < 114; i++)

                  Container(
                    color: i % 2 == 0
                        ? Colors.white60
                        : Colors.orange[100],
                    child: TextButton(
                      child: Row(
                        children: [
                          ArabicSuraNumber(i: noOfVerses[i]),
                          const SizedBox(
                            width: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                              ],
                            ),
                          ),
                          const Expanded(child: SizedBox()),
                          Text(
                            arabicName[i]['name'],
                            style: const TextStyle(
                                fontSize: 30,
                                color: Colors.black87,
                                fontFamily: 'quran',
                                // shadows: [
                                //   Shadow(
                                //     offset: Offset(.5, .5),
                                //     // blurRadius: 1.0,
                                //     color: Color.fromARGB(255, 130, 130, 130),
                                //   )
                                // ],
                            ),
                            textDirection: TextDirection.rtl,
                          ),
                        ],
                      ),
                      onPressed: () {
                        fabIsClicked = false;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SurahBuilder(
                                    arabic: quran[0],
                                    sura: i,
                                    suraName: arabicName[i]['name'],
                                     ayah: 0,
                                  )),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }


}





