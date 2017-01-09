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

class EntityTeleport extends Packet {

	public final static int ID = (int)71;

	public final static boolean CLIENTBOUND = true;
	public final static boolean SERVERBOUND = false;

	public int entityId;
	public Tuples.DoubleXYZ position;
	public byte yaw;
	public byte pitch;
	public boolean onGround;

	@Override
	public int length() {
	}

	@Override
	public byte[] encode() {
		this.buffer = new byte[this.length()];
		this.index = 0;
		this.writeVaruint(ID);
		this.writeVaruint(entityId);
		this.writeDoubleB(position.x);this.writeDoubleB(position.y);this.writeDoubleB(position.z);
		this.writeByteB(yaw);
		this.writeByteB(pitch);
		this.writeBoolB(onGround);
		return this.buffer;
	}

	@Override
	public void decode(byte[] buffer) {
		this.buffer = buffer;
		this.index = 0;
	}

}
