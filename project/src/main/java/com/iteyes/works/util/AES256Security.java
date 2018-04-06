package com.iteyes.works.util;
import java.io.UnsupportedEncodingException;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.security.spec.AlgorithmParameterSpec;
import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import org.apache.commons.codec.binary.Base64;

public class AES256Security {
    
    public static byte[] byteIv = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };
    public static String strKey = "abcdefghijklmnopqrstuvwxyz012345";
    
    
    //암호화 할 때
    public static String encrypt(String strData) throws java.io.UnsupportedEncodingException, NoSuchAlgorithmException, NoSuchPaddingException, InvalidKeyException, InvalidAlgorithmParameterException, IllegalBlockSizeException, BadPaddingException {
        byte[] byteText = strData.getBytes("UTF-8");
        AlgorithmParameterSpec aps = new IvParameterSpec(byteIv);
        SecretKeySpec sks = new SecretKeySpec(strKey.getBytes("UTF-8"), "AES");
        Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
        cipher.init(Cipher.ENCRYPT_MODE, sks, aps);
        return Base64.encodeBase64String(cipher.doFinal(byteText));
    }
    
    //암호화 풀 때
    public static String decrypt(String strData) throws java.io.UnsupportedEncodingException, NoSuchAlgorithmException, NoSuchPaddingException, InvalidKeyException, InvalidAlgorithmParameterException, IllegalBlockSizeException, BadPaddingException {
        byte[] byteText = Base64.decodeBase64(strData);
        AlgorithmParameterSpec aps = new IvParameterSpec(byteIv);
        SecretKeySpec sks = new SecretKeySpec(strKey.getBytes("UTF-8"), "AES");
        Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
        cipher.init(Cipher.DECRYPT_MODE, sks, aps);
        return new String(cipher.doFinal(byteText), "UTF-8");
    }
    
//    public static void main(String[] args) throws Exception {
//    	
//    	String str = "1234";
//    	
//    	
//    	String passwd = encrypt(str);
//    	System.out.println("입력한 패스워드: "+str);
//    	System.out.println("암호화된 패스워드 : "+passwd);
//    	
//    	str = decrypt(passwd);
//    	
//    	System.out.println("다시 가져왔어: "+str);
//    	
//    	
//    }
    
}
