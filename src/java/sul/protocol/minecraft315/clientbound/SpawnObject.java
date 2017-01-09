/*
 * This file has been automatically generated by sel-utils and
 * released under the GNU General Public License version 3.
 *
 * License: https://github.com/sel-project/sel-utils/blob/master/LICENSE
 * Repository: https://github.com/sel-project/sel-utils
 * Generator: https://github.com/sel-project/sel-utils/blob/master/xml/protocol/minecraft315.xml
 */
package sul.protocol.minecraft315.clientbound;

import java.util.UUID;

import sul.protocol.minecraft315.types.*;
import sul.utils.*;

class SpawnObject extends Packet {

	public final static int ID = (int)0;

	public final static boolean CLIENTBOUND = true;
	public final static boolean SERVERBOUND = false;

	public int entityId;
	public UUID uuid;
	public byte type;
	public Tuples.DoubleXYZ position;
	public byte pitch;
	public byte yaw;
	public int data;
	public Tuples.ShortXYZ velocity;

	@Override
	public int length() {
	}

	@Override
	public byte[] encode() {
		this.buffer = new byte[this.length()];
		this.index = 0;
		this.writeVaruint(ID);
		this.writeVaruint(entityId);
		this.writeLongB(uuid.getLeastSignificantBits()); this.writeLongB(uuid.getMostSignificantBits());
		this.writeByteB(type);
		this.writeDoubleB(position.x);this.writeDoubleB(position.y);this.writeDoubleB(position.z);
		this.writeByteB(pitch);
		this.writeByteB(yaw);
		this.writeIntB(data);
		this.writeShortB(velocity.x);this.writeShortB(velocity.y);this.writeShortB(velocity.z);
		return this.buffer;
	}

	@Override
	public void decode(byte[] buffer) {
		this.buffer = buffer;
		this.index = 0;
	}

}
