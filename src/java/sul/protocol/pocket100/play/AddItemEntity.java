/*
 * This file has been automatically generated by sel-utils and
 * released under the GNU General Public License version 3.
 *
 * License: https://github.com/sel-project/sel-utils/blob/master/LICENSE
 * Repository: https://github.com/sel-project/sel-utils
 * Generator: https://github.com/sel-project/sel-utils/blob/master/xml/protocol/pocket100.xml
 */
package sul.protocol.pocket100.play;

import java.util.UUID;

import sul.protocol.pocket100.types.*;
import sul.utils.*;

class AddItemEntity extends Packet {

	public final static byte ID = (byte)16;

	public final static boolean CLIENTBOUND = true;
	public final static boolean SERVERBOUND = false;

	public long entityId;
	public long runtimeId;
	public Slot item;
	public Tuples.FloatXYZ position;
	public Tuples.FloatXYZ motion;

	@Override
	public int length() {
	}

	@Override
	public byte[] encode() {
		this.buffer = new byte[this.length()];
		this.index = 0;
		this.writeByteB(ID);
		this.writeVarlong(entityId);
		this.writeVarlong(runtimeId);
		this.writeBytes(item.encode());
		this.writeFloatlittle_endian(position.x);this.writeFloatlittle_endian(position.y);this.writeFloatlittle_endian(position.z);
		this.writeFloatlittle_endian(motion.x);this.writeFloatlittle_endian(motion.y);this.writeFloatlittle_endian(motion.z);
		return this.buffer;
	}

	@Override
	public void decode(byte[] buffer) {
		this.buffer = buffer;
		this.index = 0;
	}

}
