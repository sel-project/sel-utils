/*
 * This file has been automatically generated by sel-utils and
 * released under the GNU General Public License version 3.
 *
 * License: https://github.com/sel-project/sel-utils/blob/master/LICENSE
 * Repository: https://github.com/sel-project/sel-utils
 * Generator: https://github.com/sel-project/sel-utils/blob/master/xml/protocol/minecraft110.xml
 */
package sul.protocol.minecraft110.serverbound;

import java.util.UUID;

import sul.protocol.minecraft110.types.*;
import sul.utils.*;

class ChatMessage extends Packet {

	public final static int ID = (int)2;

	public final static boolean CLIENTBOUND = false;
	public final static boolean SERVERBOUND = true;

	public String text;

	@Override
	public int length() {
	}

	@Override
	public byte[] encode() {
		this.buffer = new byte[this.length()];
		this.index = 0;
		this.writeVaruint(ID);
		byte[] dGV4dA=text.getBytes("UTF-8"); this.writeVaruint((int)dGV4dA.length); this.writeBytes(dGV4dA);
		return this.buffer;
	}

	@Override
	public void decode(byte[] buffer) {
		this.buffer = buffer;
		this.index = 0;
	}

}
