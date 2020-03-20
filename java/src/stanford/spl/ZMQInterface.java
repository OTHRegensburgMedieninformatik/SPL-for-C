/*
 * File: ZMQInterface.java 
 * ----------------------- 
 * This file implements the ZMQ-Interface for the JBE for binary transport 
 * of data to the C FrontEnd.
 */

/*************************************************************************/
/* Stanford Portable Library                                             */
/* Copyright (C) 2013 by Eric Roberts <eroberts@cs.stanford.edu>         */
/*                                                                       */
/* This program is free software: you can redistribute it and/or modify  */
/* it under the terms of the GNU General Public License as published by  */
/* the Free Software Foundation, either version 3 of the License, or     */
/* (at your option) any later version.                                   */
/*                                                                       */
/* This program is distributed in the hope that it will be useful,       */
/* but WITHOUT ANY WARRANTY; without even the implied warranty of        */
/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         */
/* GNU General Public License for more details.                          */
/*                                                                       */
/* You should have received a copy of the GNU General Public License     */
/* along with this program.  If not, see <http://www.gnu.org/licenses/>. */
/*************************************************************************/

package stanford.spl;

import org.zeromq.ZMQ;
import org.zeromq.ZMQException;
import org.zeromq.SocketType;
import org.zeromq.ZContext;

public class ZMQInterface {

   private boolean debug;
   private ZContext context;
   private ZMQ.Socket server;
   private ZMQ.Socket client;
   private int server_port;

   public ZMQInterface(boolean debug, int port_recv, int port_send) {
      this.debug = debug;
      context = new ZContext();
      server = context.createSocket(SocketType.REP);
      client = context.createSocket(SocketType.REQ);
      boolean bound = false;

      while (!bound) {
         try {
            server.bind("tcp://*:" + port_recv);
            bound = true;
            server_port = port_recv;
            if (this.debug)
               System.err.println(
                     "JavaBackEnd: ZMQInterface: Server listening at port " + port_recv + ".");
         } catch (ZMQException ex) {
            if (this.debug)
               System.err.println("JavaBackEnd: ZMQInterface: Port " + port_recv
                     + " is already occupied, trying port " + (port_recv + 1) + ".");
            port_recv++;
         }
      }

      try {
         client.connect("tcp://localhost:" + port_send);
         if (this.debug)
            System.err.println("JavaBackEnd: ZMQInterface: Client now sends messages to port "
                  + port_send + ".");
      } catch (ZMQException ex) {
         if (this.debug)
            System.err.println(
                  "JavaBackEnd: ZMQInterface: Client could not connect to port " + port_send + ".");
      }

      if (this.debug)
         System.err.println("JavaBackEnd: ZMQInterface: Initialized ZMQInterface.");

   }

   public int getServerPort() {
      return server_port;
   }


   // public void sendString(String str) {
   // client.send(str.getBytes(ZMQ.CHARSET), 0);
   // }

   // public String recvString() {
   // return server.recvStr();
   // }

   public void sendIntArray(int[] arr, boolean last) {
      byte[] len_bin = new byte[4];
      byte[] arr_bin = new byte[arr.length << 2];
      int len = arr.length;

      len_bin[0] = (byte) ((len >>> 0) & 0xff);
      len_bin[1] = (byte) ((len >>> 8) & 0xff);
      len_bin[2] = (byte) ((len >>> 16) & 0xff);
      len_bin[3] = (byte) ((len >>> 24) & 0xff);
      client.send(len_bin, ZMQ.SNDMORE);

      for (int i = 0; i < arr.length; i++) {
         int x = arr[i];
         int j = i << 2;
         arr_bin[j++] = (byte) ((x >>> 0) & 0xff);
         arr_bin[j++] = (byte) ((x >>> 8) & 0xff);
         arr_bin[j++] = (byte) ((x >>> 16) & 0xff);
         arr_bin[j++] = (byte) ((x >>> 24) & 0xff);
      }
      if (last) {
         client.send(arr_bin, 0);
         String reply = new String(client.recv(0), ZMQ.CHARSET);
         if (this.debug) {
            if(reply.equals("0")) {
               System.err.println("JavaBackEnd: ZMQInterface: Successfully send data to Server.");
            } else {
               System.err.println("JavaBackEnd: ZMQInterface: Something went wrong, while sending data to " +
                  "Server. Server returned ZMQinterface-Error #" + reply);
            }
         }
      } else {
         client.send(arr_bin, ZMQ.SNDMORE);
      }
   }

   public void sendConfirmationReply() {
      String msg = "0";
      server.send(msg.getBytes(ZMQ.CHARSET), 0);
      if (this.debug)
         System.err.println(
               "JavaBackEnd: ZMQInterface: Successfully received data from Client. Sending confirmation to Client.");
   }

   public int[] recvIntArray() {
      byte[] arr_bin = server.recv(0);
      int[] arr = new int[arr_bin.length >>> 2];

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

   public void destroy() {
      context.close();
      if (this.debug)
         System.err.println("JavaBackEnd: ZMQInterface: Destroyed ZMQInterface.");
   }

}
