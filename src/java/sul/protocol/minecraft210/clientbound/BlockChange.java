/*
 * This file has been automatically generated by sel-utils and
 * released under the GNU General Public License version 3.
 *
 * License: https://github.com/sel-project/sel-utils/blob/master/LICENSE
 * Repository: https://github.com/sel-project/sel-utils
 * Generator: https://github.com/sel-project/sel-utils/blob/master/xml/protocol/minecraft210.xml
 */
package sul.protocol.minecraft210.clientbound;

import java.util.UUID;

import sul.protocol.minecraft210.types.*;
import sul.utils.*;

class BlockChange extends Packet {

	public final static int ID = (int)11;

	public final static boolean CLIENTBOUND = true;
	public final static boolean SERVERBOUND = false;

	public long position;
	public int block;

	@Override
	public int length() {
	}

	@Override
	public byte[] encode() {
		this.buffer = new byte[this.length()];
		this.index = 0;
		this.writeVaruint(ID);
		this.writeLongB(position);
		this.writeVaruint(block);
		return this.buffer;
	}

	@Override
	public void decode(byte[] buffer) {
		this.buffer = buffer;
		this.index = 0;
	}

}
