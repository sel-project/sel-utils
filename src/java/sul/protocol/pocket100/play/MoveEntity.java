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

class MoveEntity extends Packet {

	public final static byte ID = (byte)19;

	public final static boolean CLIENTBOUND = true;
	public final static boolean SERVERBOUND = false;

	public long entityId;
	public Tuples.FloatXYZ position;
	public byte pitch;
	public byte headYaw;
	public byte yaw;

	@Override
	public int length() {
	}

	@Override
	public byte[] encode() {
		this.buffer = new byte[this.length()];
		this.index = 0;
		this.writeByteB(ID);
		this.writeVarlong(entityId);
		this.writeFloatlittle_endian(position.x);this.writeFloatlittle_endian(position.y);this.writeFloatlittle_endian(position.z);
		this.writeByteB(pitch);
		this.writeByteB(headYaw);
		this.writeByteB(yaw);
		return this.buffer;
	}

	@Override
	public void decode(byte[] buffer) {
		this.buffer = buffer;
		this.index = 0;
	}

}
