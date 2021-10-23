import 'dart:io';
import 'dart:math';
import 'package:nyxx/nyxx.dart';
Future<void> addToFile(String textToAdd) async{
  var file = await File("bin/quotes.txt").writeAsString(textToAdd,mode: FileMode.append);
}
Future<void> readFromFile() async{
    File('bin/quotes.txt').readAsLines().then((List<String> contents) {
      quotes=[];
      contents.forEach((element) {
        quotes.add(element);
      });
  });
  length=quotes.length;
}
List<String> quotes = [
    
  ];

  int length = 0;
void main() async{
 
  final bot = Nyxx("OTAxMjE1NTU4NTM4Nzg0Nzg4.YXMoZA.lxjTejT0BgP0mYfL_kPXYw5Mpsw", GatewayIntents.allUnprivileged);
  await readFromFile();
 
  
  bot.onReady.listen((e) {
    print("Ready!");
   
    length = quotes.length;
    
  });

  
  bot.onMessageReceived.listen((e) async{
    length = quotes.length;
    var embedder = EmbedBuilder();
    embedder.title = "Get Motivated";
    embedder.color = DiscordColor.blue;
   
    if (e.message.content == "random") {
      var rng = Random();
      int index = rng.nextInt(length);
      
      embedder.description = quotes[index];
      e.message.channel.sendMessage(MessageBuilder.embed(embedder));
    }else if(e.message.content.contains("add ")){
      String abc = e.message.content.toString();
      await addToFile('\n'+abc.substring(4));
      await readFromFile();
     
      
    }else if(e.message.content.contains("index ")){
      int idx = int.parse(e.message.content.substring(6));
      if(idx>=length){
        e.message.channel.sendMessage(MessageBuilder.content("Enter index from 0 to ${length-1}"));
      }
      embedder.description = quotes[idx];
      e.message.channel.sendMessage(MessageBuilder.embed(embedder));
    }
  });
} 