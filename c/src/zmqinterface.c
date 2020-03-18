#include "zmqinterface.h"

#include "zmq.h"

struct ZMQInterfaceCDT {
   void *context;
   void *server;
   void *client;
};

ZMQInterface newZMQInterface(int port_recv, int port_send) {
   ZMQInterface iface = newBlock(ZMQInterface);
   int rc;

   iface->context = zmq_ctx_new();
   iface->server = zmq_socket(iface->context, ZMQ_REP);
   iface->client = zmq_socket(iface->context, ZMQ_REQ);

   // FIXME: make ports better
   rc = zmq_bind(iface->server, "tcp://*:5555");
#ifdef ZMQDEBUG
   if (rc == -1)
      fprintf(stderr,
              "DEBUG: ZMQInterface failed to open Server. Port occupied.\n");
#endif

   rc = zmq_connect(iface->client, "tcp://localhost:5556");
#ifdef ZMQDEBUG
   if (rc == -1)
      fprintf(stderr, "DEBUG: ZMQInterface failed to connect to Server.\n");

   fprintf(stderr, "DEBUG: ZMQInterface-instance created.\n");
#endif
   return iface;
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
   if (last)
      zmq_send(iface->client, (byte *)str, stringLength(str), 0);
   else
      zmq_send(iface->client, (byte *)str, stringLength(str), ZMQ_SNDMORE);
}

string recvString(ZMQInterface iface, int buffer_len) {
   string str = newArray(buffer_len, char);

   zmq_recv(iface->server, str, buffer_len, 0);
   return str;
}

void sendIntArray(ZMQInterface iface, int *arr, int len, bool last) {
   if (last)
      zmq_send(iface->client, (byte *)arr, len * sizeof(int), 0);
   else
      zmq_send(iface->client, (byte *)arr, len * sizeof(int), ZMQ_SNDMORE);
}

void recvIntArray(ZMQInterface iface, int **arr) {
   int len = 0;
   zmq_recv(iface->server, (byte *)&len, sizeof(int), 0);
   *arr = newArray(len, int);
   zmq_recv(iface->server, (byte *)(*arr), len * sizeof(int), 0);
}