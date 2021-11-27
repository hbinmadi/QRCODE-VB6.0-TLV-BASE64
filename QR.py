import base64
import sys



message = "012C42696E204D61646920436F6D707574657273204B68616D69732F6862696E6D616469407961686F6F2E636F6D020F3331303132323339333530303030330315323032322D30342D32352031353A33303A3030414D0407313030302E303005063135302E3030"
if len(sys.argv)>1:
   print(sys.argv[1])
   message= sys.argv[1]
#message_bytes = message.encode('UTF-8')
#base64_bytes = base64.encodebytes(message_bytes)
#base64_message = base64_bytes.decode('ascii')

from base64 import b64encode, b64decode



# hex -> base64
#s == message
b64 = b64encode(bytes.fromhex(message)).decode()
#print('base64:', b64)

# base64 -> hex
s2 = b64decode(b64.encode()).hex()
#print('hex:', s2)

with open('QrCode.txt', 'w') as f:
    f.write(b64)

