package user;

import java.util.Random;

public class CertifiedPhoneNumber {

    public String randomNumber(String number1){

        // 랜덤값 4자리 생성
        Random rand  = new Random();
        String cerNum="";

        for(int i=0; i<4; i++) {
            String ran = Integer.toString(rand.nextInt(10));
            cerNum+=ran;
        }

        RequestMessage exampleSend = new RequestMessage();
        exampleSend.sendMessage(number1, cerNum);
        return cerNum;

    }



}
