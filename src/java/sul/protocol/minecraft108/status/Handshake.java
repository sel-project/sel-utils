/*
 * This file has been automatically generated by sel-utils and
 * released under the GNU General Public License version 3.
 *
 * License: https://github.com/sel-project/sel-utils/blob/master/LICENSE
 * Repository: https://github.com/sel-project/sel-utils
 * Generator: https://github.com/sel-project/sel-utils/blob/master/xml/protocol/minecraft108.xml
 */
package sul.protocol.minecraft108.status;

import java.util.UUID;

import sul.protocol.minecraft108.types.*;
import sul.utils.*;

class Handshake extends Packet {

	public final static int ID = (int)0;

	public final static boolean CLIENTBOUND = false;
	public final static boolean SERVERBOUND = true;

	// next
	public static immutable int STATUS = 1;
	public static immutable int LOGIN = 2;

	public int protocol;
	public String serverAddress;
	public short serverPort;
	public int next;

	@Override
	public int length() {
	}

	@Override
	public byte[] encode() {
		this.buffer = new byte[this.length()];
		this.index = 0;
		this.writeVaruint(ID);
		this.writeVaruint(protocol);
		byte[] c2VydmVyQWRkcmVz=serverAddress.getBytes("UTF-8"); this.writeVaruint((int)c2VydmVyQWRkcmVz.length); this.writeBytes(c2VydmVyQWRkcmVz);
		this.writeShortB(serverPort);
		this.writeVaruint(next);
		return this.buffer;
	}

	@Override
	public void decode(byte[] buffer) {
		this.buffer = buffer;
		this.index = 0;
	}

}
