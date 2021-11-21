package callers;

import net.minidev.json.JSONObject;

import java.io.FileWriter;
import java.io.IOException;

public class JsonFileWrite {

    public static void StringRandomCreator(String email) {
        FileWriter file = null;
        JSONObject obj = new JSONObject();
        obj.put("email",email);
        try {
            file = new FileWriter("src/test/java/helper/emailData.json");
            file.write(obj.toJSONString());
        } catch (IOException e) {
            e.printStackTrace();

        } finally {

            try {
                file.flush();
                file.close();
            } catch (IOException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
    }
}
