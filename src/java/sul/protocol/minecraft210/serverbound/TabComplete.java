/*
 * This file has been automatically generated by sel-utils and
 * released under the GNU General Public License version 3.
 *
 * License: https://github.com/sel-project/sel-utils/blob/master/LICENSE
 * Repository: https://github.com/sel-project/sel-utils
 * Generator: https://github.com/sel-project/sel-utils/blob/master/xml/protocol/minecraft210.xml
 */
package sul.protocol.minecraft210.serverbound;

import java.util.UUID;

import sul.protocol.minecraft210.types.*;
import sul.utils.*;

class TabComplete extends Packet {

	public final static int ID = (int)1;

	public final static boolean CLIENTBOUND = false;
	public final static boolean SERVERBOUND = true;

	public String text;
	public boolean command;
	public boolean hasPosition;
	public long block;

	@Override
	public int length() {
	}

	@Override
	public byte[] encode() {
		this.buffer = new byte[this.length()];
		this.index = 0;
		this.writeVaruint(ID);
		byte[] dGV4dA=text.getBytes("UTF-8"); this.writeVaruint((int)dGV4dA.length); this.writeBytes(dGV4dA);
		this.writeBoolB(command);
		this.writeBoolB(hasPosition);
		if(has_position==true){ this.writeLongB(block); }
		return this.buffer;
	}

	@Override
	public void decode(byte[] buffer) {
		this.buffer = buffer;
		this.index = 0;
	}

}
