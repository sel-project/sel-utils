/*
 * This file has been automatically generated by sel-utils and
 * released under the GNU General Public License version 3.
 *
 * License: https://github.com/sel-project/sel-utils/blob/master/LICENSE
 * Repository: https://github.com/sel-project/sel-utils
 * Generator: https://github.com/sel-project/sel-utils/blob/master/xml/protocol/hncom1.xml
 */
package sul.protocol.hncom1.player;

import java.util.UUID;

import sul.protocol.hncom1.types.*;
import sul.utils.*;

class Transfer extends Packet {

	public final static byte ID = (byte)13;

	public final static boolean CLIENTBOUND = false;
	public final static boolean SERVERBOUND = true;

	public int hubId;
	public String node;

	@Override
	public int length() {
	}

	@Override
	public byte[] encode() {
		this.buffer = new byte[this.length()];
		this.index = 0;
		this.writeByteB(ID);
		this.writeVaruint(hubId);
		byte[] bm9kzq=node.getBytes("UTF-8"); this.writeVaruint((int)bm9kzq.length); this.writeBytes(bm9kzq);
		return this.buffer;
	}

	@Override
	public void decode(byte[] buffer) {
		this.buffer = buffer;
		this.index = 0;
	}

}