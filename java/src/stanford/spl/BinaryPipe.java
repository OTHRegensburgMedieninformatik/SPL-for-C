package stanford.spl;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;

public class BinaryPipe {

   private String stream_path;
   private ArrayList<byte[]> cache;

   public BinaryPipe(String path) {
      File f = new File(path);
      f.deleteOnExit();
      this.stream_path = path;
      this.cache = new ArrayList<byte[]>();
   }

   private byte[] readWholeFile() {
      try {
         File stream_file = new File(this.stream_path);
         FileInputStream fis = new FileInputStream(stream_file);
         byte[] data = new byte[(int) stream_file.length()];
         fis.read(data);
         fis.close();
         stream_file.delete();
         return data;
      } catch (FileNotFoundException e) {
         e.printStackTrace();
      } catch (IOException e) {
         e.printStackTrace();
      }
      return null;
   }

   /* ----------- WRITE ----------- */

   public void write(int i) {
      byte[] i_bin = new byte[4];

      i_bin[0] = (byte) ((i >>> 0) & 0xff);
      i_bin[1] = (byte) ((i >>> 8) & 0xff);
      i_bin[2] = (byte) ((i >>> 16) & 0xff);
      i_bin[3] = (byte) ((i >>> 24) & 0xff);

      cache.add(i_bin);
   }

   public void write(int[] arr) {
      // write((int) arr.length);
      byte[] arr_bin = new byte[arr.length << 2];

      for (int i = 0; i < arr.length; i++) {
         int x = arr[i];
         int j = i << 2;
         arr_bin[j++] = (byte) ((x >>> 0) & 0xff);
         arr_bin[j++] = (byte) ((x >>> 8) & 0xff);
         arr_bin[j++] = (byte) ((x >>> 16) & 0xff);
         arr_bin[j++] = (byte) ((x >>> 24) & 0xff);
      }

      cache.add(arr_bin);
   }

   public int[][] readIntArr(int width, int height) {
      byte[] data = readWholeFile();
      int[][] pixels = new int[height][width];

      for (int i = 0; i < height; i++) {
         for (int k = 0; k < width; k++) {
            int j = ((k + width * i) << 2);
            int x = 0;
            x += (data[j++] & 0xff) << 0;
            x += (data[j++] & 0xff) << 8;
            x += (data[j++] & 0xff) << 16;
            x += (data[j++] & 0xff) << 24;
            pixels[i][k] = x;
         }
      }
      return pixels;
   }

   /* ----------- FLUSH ----------- */

   public void flush() {

      try {
         File f = new File(this.stream_path);
         f.delete();
         File stream_file = new File(this.stream_path);
         FileOutputStream fos = new FileOutputStream(stream_file);
         for (byte[] bs : cache)
            fos.write(bs);
         fos.close();
      } catch (IOException e) {
         e.printStackTrace();
      }

      cache.clear();
   }

}