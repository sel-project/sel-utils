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

class AddPlayer extends Packet {

	public final static byte ID = (byte)13;

	public final static boolean CLIENTBOUND = true;
	public final static boolean SERVERBOUND = false;

	public UUID uuid;
	public String username;
	public long entityId;
	public long runtimeId;
	public Tuples.FloatXYZ position;
	public Tuples.FloatXYZ motion;
	public float pitch;
	public float headYaw;
	public float yaw;
	public Slot heldItem;
	public Metadata metadata;

	@Override
	public int length() {
	}

	@Override
	public byte[] encode() {
		this.buffer = new byte[this.length()];
		this.index = 0;
		this.writeByteB(ID);
		this.writeLongB(uuid.getLeastSignificantBits()); this.writeLongB(uuid.getMostSignificantBits());
		byte[] dXNlcm5hbWU=username.getBytes("UTF-8"); this.writeVaruint((int)dXNlcm5hbWU.length); this.writeBytes(dXNlcm5hbWU);
		this.writeVarlong(entityId);
		this.writeVarlong(runtimeId);
		this.writeFloatlittle_endian(position.x);this.writeFloatlittle_endian(position.y);this.writeFloatlittle_endian(position.z);
		this.writeFloatlittle_endian(motion.x);this.writeFloatlittle_endian(motion.y);this.writeFloatlittle_endian(motion.z);
		this.writeFloatlittle_endian(pitch);
		this.writeFloatlittle_endian(headYaw);
		this.writeFloatlittle_endian(yaw);
		this.writeBytes(heldItem.encode());
		this.writeBytes(metadata.encode());
		return this.buffer;
	}

	@Override
	public void decode(byte[] buffer) {
		this.buffer = buffer;
		this.index = 0;
	}

}
