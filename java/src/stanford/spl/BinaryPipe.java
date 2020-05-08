package stanford.spl;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;

public class BinaryPipe {

   private FileInputStream fis;
   private FileOutputStream fos;
   private File stream_file;
   private ArrayList<byte[]> cache;

   public BinaryPipe(String path) {
      this.stream_file = new File(path);
      this.cache = new ArrayList<byte[]>();
   }

   /* ----------- CONVERT ----------- */

   private byte[] str_to_byte(String str) {
      return str.getBytes(StandardCharsets.UTF_8);
   }

   private byte[] int_to_byte(int i) {
      byte[] data = new byte[4];

      data[0] = (byte) ((i >>> 0) & 0xff);
      data[1] = (byte) ((i >>> 8) & 0xff);
      data[2] = (byte) ((i >>> 16) & 0xff);
      data[3] = (byte) ((i >>> 24) & 0xff);

      return data;
   }

   private byte[] intArr_to_byte(int[] arr) {
      byte[] arr_bin = new byte[arr.length << 2];

      for (int i = 0; i < arr.length; i++) {
         int x = arr[i];
         int j = i << 2;
         arr_bin[j++] = (byte) ((x >>> 0) & 0xff);
         arr_bin[j++] = (byte) ((x >>> 8) & 0xff);
         arr_bin[j++] = (byte) ((x >>> 16) & 0xff);
         arr_bin[j++] = (byte) ((x >>> 24) & 0xff);
      }
      return arr_bin;
   }

   /* ----------- WRITE ----------- */

   public void write(String str) {
      cache.add(str_to_byte(str));
   }

   public void write(int i) {
      cache.add(int_to_byte(i));
   }

   public void write(int[] arr) {
      write(arr.length);
      cache.add(intArr_to_byte(arr));
   }

   /* ----------- READ ----------- */

   public String readString() {
      int len = readInt();
      byte[] bytes = new byte[len];

      try {
         if (fis == null)
            fis = new FileInputStream(stream_file);
         fis.read(bytes);
      } catch (IOException e) {
         e.printStackTrace();
      }
      return new String(bytes);
   }

   public int readInt() {
      byte[] bytes = new byte[4];

      try {
         if (fis == null)
            fis = new FileInputStream(stream_file);
         fis.read(bytes);
      } catch (IOException e) {
         e.printStackTrace();
      }

      int x = 0;
      x += (bytes[0] & 0xff) << 0;
      x += (bytes[1] & 0xff) << 8;
      x += (bytes[2] & 0xff) << 16;
      x += (bytes[3] & 0xff) << 24;
      return x;
   }

   public int[] readIntArr() {
      int len = readInt();
      byte[] arr_bin = new byte[len << 2];
      try {
         if (fis == null)
            fis = new FileInputStream(stream_file);
         fis.read(arr_bin);
      } catch (IOException e) {
         e.printStackTrace();
      }

      int[] arr = new int[len];
      for (int i = 0; i < arr.length; i++) {
         int j = i << 2;
         int x = 0;
         x += (arr_bin[j++] & 0xff) << 0;
         x += (arr_bin[j++] & 0xff) << 8;
         x += (arr_bin[j++] & 0xff) << 16;
         x += (arr_bin[j++] & 0xff) << 24;
         arr[i] = x;
      }
      return arr;
   }

   /* ----------- FLUSH ----------- */

   public void flush() {
      int len = 0;
      for (byte[] arr : cache)
         len += arr.length;

      byte[] bytes = new byte[len];
      int index = 0;
      for (byte[] arr : cache) {
         for (int i = 0; i < arr.length; i++)
            bytes[index + i] = arr[i];
         index += arr.length;
      }

      try {
         stream_file.delete();
         if (fos == null)
            fos = new FileOutputStream(stream_file);
         fos.write(bytes);
         closeFos();
      } catch (IOException e) {
         e.printStackTrace();
      }

      cache.clear();
   }

   public void closeFos() {
      try {
         fos.close();
      } catch (IOException e) {
         e.printStackTrace();
      }
      fos = null;
   }

   public void closeFis() {
      try {
         fis.close();
      } catch (IOException e) {
         e.printStackTrace();
      }
      fis = null;
      stream_file.delete();
   }

}