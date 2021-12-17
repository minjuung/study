package user;

import net.nurigo.java_sdk.Coolsms;
import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;
import util.EnvBeige;

import org.json.simple.JSONObject;

import java.util.HashMap;


public class RequestMessage {

        public void sendMessage(String phoneNumber1, String cerNum){
            String api_key = EnvBeige.coolsmsApiKey;
            String api_secret = EnvBeige.coolsmsApiSecret;
            Message coolsms = new Message(api_key, api_secret);

            // 4 params(to, from, type, text) are mandatory. must be filled
            HashMap<String, String> params = new HashMap<String, String>();

            //수신번호
            params.put("to", phoneNumber1);
            //발신번호
            params.put("from", EnvBeige.coolsmsNumber);
            params.put("type", "SMS");
            //문자내용
            params.put("text", "인증번호는 "+cerNum+"입니다.");
            params.put("app_version", "test app 1.2"); // application name and version

            try {
                JSONObject obj = (JSONObject) coolsms.send(params);
                System.out.println(obj.toString());
            } catch (CoolsmsException e) {
                System.out.println(e.getMessage());
                System.out.println(e.getCode());
            }

        }
}
