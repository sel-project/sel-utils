/*
 * This file has been automatically generated by sel-utils and
 * released under the GNU General Public License version 3.
 *
 * License: https://github.com/sel-project/sel-utils/blob/master/LICENSE
 * Repository: https://github.com/sel-project/sel-utils
 * Generator: https://github.com/sel-project/sel-utils/blob/master/xml/protocol/minecraft47.xml
 */
package sul.protocol.minecraft47.clientbound;

import java.util.UUID;

import sul.protocol.minecraft47.types.*;
import sul.utils.*;

class BlockBreakAnimation extends Packet {

	public final static int ID = (int)37;

	public final static boolean CLIENTBOUND = true;
	public final static boolean SERVERBOUND = false;

	public int entityId;
	public long position;
	public byte stage;

	@Override
	public int length() {
	}

	@Override
	public byte[] encode() {
		this.buffer = new byte[this.length()];
		this.index = 0;
		this.writeVaruint(ID);
		this.writeVaruint(entityId);
		this.writeLongB(position);
		this.writeByteB(stage);
		return this.buffer;
	}

	@Override
	public void decode(byte[] buffer) {
		this.buffer = buffer;
		this.index = 0;
	}

}
