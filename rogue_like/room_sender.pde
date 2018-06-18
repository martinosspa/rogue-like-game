class RoomSender {
  ArrayList<JSONObject> rooms_right = new ArrayList<JSONObject>();
  ArrayList<JSONObject> rooms_down = new ArrayList<JSONObject>();
  ArrayList<JSONObject> rooms_left = new ArrayList<JSONObject>();
  ArrayList<JSONObject> rooms_up = new ArrayList<JSONObject>();
  ArrayList<JSONObject> rooms_all = new ArrayList<JSONObject>();

  RoomSender() {
    ArrayList<String> file_names = new ArrayList<String>();
    file_names.add("room0.json");
    file_names.add("room1.json");
    file_names.add("room2.json");
    file_names.add("room3.json");
    file_names.add("room4.json");
    file_names.add("room5.json");
    file_names.add("room6.json");
    file_names.add("room7.json");
    file_names.add("room8.json");
    file_names.add("room9.json");
    file_names.add("room10.json");
    file_names.add("room11.json");
    file_names.add("room12.json");
    file_names.add("room13.json");
    file_names.add("room14.json");
    file_names.add("room15.json");


    for (int i = 0; i < file_names.size(); i++) {
      JSONObject json = loadJSONObject(file_names.get(i));
      rooms_all.add(json);
      if (json.getJSONObject("connections").getBoolean("right")) {
        rooms_right.add(json);
      } 
      if (json.getJSONObject("connections").getBoolean("down")) {
        rooms_down.add(json);
      }
      if (json.getJSONObject("connections").getBoolean("left")) {
        rooms_left.add(json);
      }
      if (json.getJSONObject("connections").getBoolean("up")) {
        rooms_up.add(json);
      }
    }
  }

  JSONObject request(boolean[] conditions) {
    for (int i = 0; i < rooms_all.size(); i++) {
      JSONObject jsonRoom = rooms_all.get(i);
      if (jsonRoom.getJSONObject("connections").getBoolean("right") == conditions[0] && jsonRoom.getJSONObject("connections").getBoolean("down") == conditions[1]) {
        if (jsonRoom.getJSONObject("connections").getBoolean("left") == conditions[2] && jsonRoom.getJSONObject("connections").getBoolean("up") == conditions[3]) {
          return jsonRoom;
        }
      }
    }
    println("no match for > " + conditions[0], conditions[1], conditions[2], conditions[3]);
    return null;
  }
}
