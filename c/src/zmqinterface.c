#include "zmqinterface.h"

#include "zmq.h"

struct ZMQInterfaceCDT {
   void *context;
   void *server;
   void *client;
};

ZMQInterface newZMQInterface(int port_recv, int port_send) {
   ZMQInterface iface = newBlock(ZMQInterface);
   int rc = 0;

   iface->context = zmq_ctx_new();
   iface->server = zmq_socket(iface->context, ZMQ_REP);
   iface->client = zmq_socket(iface->context, ZMQ_REQ);

   do {
      string tmp = concat("tcp://*:", integerToString(port_recv));
      rc = zmq_bind(iface->server, (char *)tmp);
      port_recv++;

#ifdef ZMQDEBUG
      if (rc == -1) {
         fprintf(stderr,
                 "DEBUG: ZMQInterface failed to open Server. Port %d occupied, "
                 "trying port %d.\n",
                 port_recv - 1, port_recv);
      } else {
         fprintf(stderr,
                 "DEBUG: ZMQInterface successfully opened Server at port %d\n",
                 port_recv - 1);
      }
#endif

   } while (rc == -1);

   string tmp = concat("tcp://localhost:", integerToString(port_send));
   rc = zmq_connect(iface->client, (char *)tmp);

#ifdef ZMQDEBUG
   if (rc == -1) {
      fprintf(stderr, "DEBUG: ZMQInterface failed to connect to %s.\n", tmp);
   } else {
      fprintf(
          stderr,
          "DEBUG: ZMQInterface successfully changed client-connection to %s.\n",
          tmp);
   }
#endif

   return iface;
}

void updateClientPort(ZMQInterface iface, int port_send) {
   zmq_close(iface->client);
   iface->client = zmq_socket(iface->context, ZMQ_REQ);
   string tmp = concat("tcp://localhost:", integerToString(port_send));
   int rc = zmq_connect(iface->client, (char *)tmp);

#ifdef ZMQDEBUG
   if (rc == -1) {
      fprintf(stderr, "DEBUG: ZMQInterface failed to connect to %s.\n", tmp);
   } else {
      fprintf(stderr, "DEBUG: ZMQInterface successfully connected to %s.\n",
              tmp);
   }
#endif
}

// FIXME: Need to call @end of program
void freeZMQInterface(ZMQInterface iface) {
   zmq_close(iface->client);
   zmq_close(iface->server);
   zmq_ctx_destroy(iface->context);
   free(iface);

#ifdef ZMQDEBUG
   fprintf(stderr, "DEBUG: ZMQInterface-instance destroyed.\n");
#endif
}

void sendString(ZMQInterface iface, string str, bool last) {
   if (last) {
      zmq_send(iface->client, (byte *)str, stringLength(str), 0);
      char reply[2];
      zmq_recv(iface->client, reply, 2, 0);

#ifdef ZMQDEBUG
      if (stringEqual((string)reply, "0")) {
         fprintf(stderr,
                 "DEBUG: ZMQInterface successfully send data to Server.\n");
      } else {
         fprintf(stderr,
                 "DEBUG: Something went wrong, while sending data to Server. "
                 "Server returned ZMQinterface-Error #%s.\n",
                 reply);
      }
#endif

   } else {
      zmq_send(iface->client, (byte *)str, stringLength(str), ZMQ_SNDMORE);
   }
}

string recvString(ZMQInterface iface, int buffer_len) {
   string str = newArray(buffer_len, char);

   zmq_recv(iface->server, str, buffer_len, 0);
   return str;
}

void sendIntArray(ZMQInterface iface, int *arr, int len, bool last) {
   if (last) {
      zmq_send(iface->client, (byte *)arr, len * sizeof(int), 0);
      char reply[2];
      zmq_recv(iface->client, reply, 2, 0);

#ifdef ZMQDEBUG
      if (stringEqual((string)reply, "0")) {
         fprintf(stderr,
                 "DEBUG: ZMQInterface successfully send data to Server.\n");
      } else {
         fprintf(stderr,
                 "DEBUG: Something went wrong, while sending data to Server. "
                 "Server returned ZMQinterface-Error #%s.\n",
                 reply);
      }
#endif

   } else {
      zmq_send(iface->client, (byte *)arr, len * sizeof(int), ZMQ_SNDMORE);
   }
}

void recvIntArray(ZMQInterface iface, int **arr) {
   int len = 0;
   zmq_recv(iface->server, (byte *)&len, sizeof(int), 0);
   *arr = newArray(len, int);
   zmq_recv(iface->server, (byte *)(*arr), len * sizeof(int), 0);
}

void sendConfirmationReply(ZMQInterface iface) {
   zmq_send(iface->server, "0", 1, 0);
#ifdef ZMQDEBUG
   fprintf(stderr,
           "DEBUG: ZMQInterface successfully received data from Client. "
           "Sending confirmation to Client.\n");
#endif
}