/*
 * This file has been automatically generated by sel-utils and
 * released under the GNU General Public License version 3.
 *
 * License: https://github.com/sel-project/sel-utils/blob/master/LICENSE
 * Repository: https://github.com/sel-project/sel-utils
 * Generator: https://github.com/sel-project/sel-utils/blob/master/xml/protocol/minecraft110.xml
 */
package sul.protocol.minecraft110.clientbound;

import java.util.UUID;

import sul.protocol.minecraft110.types.*;
import sul.utils.*;

class OpenWindow extends Packet {

	public final static int ID = (int)19;

	public final static boolean CLIENTBOUND = true;
	public final static boolean SERVERBOUND = false;

	public byte window;
	public String type;
	public String title;
	public byte slots;

	@Override
	public int length() {
	}

	@Override
	public byte[] encode() {
		this.buffer = new byte[this.length()];
		this.index = 0;
		this.writeVaruint(ID);
		this.writeByteB(window);
		byte[] dHlwZQ=type.getBytes("UTF-8"); this.writeVaruint((int)dHlwZQ.length); this.writeBytes(dHlwZQ);
		byte[] dGl0bGU=title.getBytes("UTF-8"); this.writeVaruint((int)dGl0bGU.length); this.writeBytes(dGl0bGU);
		this.writeByteB(slots);
		return this.buffer;
	}

	@Override
	public void decode(byte[] buffer) {
		this.buffer = buffer;
		this.index = 0;
	}

}
