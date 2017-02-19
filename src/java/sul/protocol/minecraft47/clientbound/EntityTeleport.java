/*
 * This file was automatically generated by sel-utils and
 * released under the GNU General Public License version 3.
 * 
 * License: https://github.com/sel-project/sel-utils/blob/master/LICENSE
 * Repository: https://github.com/sel-project/sel-utils
 * Generated from https://github.com/sel-project/sel-utils/blob/master/xml/protocol/minecraft47.xml
 */
package sul.protocol.minecraft47.clientbound;

import sul.utils.*;

public class EntityTeleport extends Packet {

	public static final int ID = (int)24;

	public static final boolean CLIENTBOUND = true;
	public static final boolean SERVERBOUND = false;

	@Override
	public int getId() {
		return ID;
	}

	public int entityId;
	public Tuples.IntXYZ position = new Tuples.IntXYZ();
	public byte yaw;
	public byte pitch;
	public boolean onGround;

	public EntityTeleport() {}

	public EntityTeleport(int entityId, Tuples.IntXYZ position, byte yaw, byte pitch, boolean onGround) {
		this.entityId = entityId;
		this.position = position;
		this.yaw = yaw;
		this.pitch = pitch;
		this.onGround = onGround;
	}

	@Override
	public int length() {
		return Buffer.varuintLength(entityId) + 16;
	}

	@Override
	public byte[] encode() {
		this._buffer = new byte[this.length()];
		this.writeVaruint(ID);
		this.writeVaruint(entityId);
		this.writeBigEndianInt(position.x); this.writeBigEndianInt(position.y); this.writeBigEndianInt(position.z);
		this.writeBigEndianByte(yaw);
		this.writeBigEndianByte(pitch);
		this.writeBool(onGround);
		return this.getBuffer();
	}

	@Override
	public void decode(byte[] buffer) {
		this._buffer = buffer;
		this.readVaruint();
		entityId=this.readVaruint();
		position=new Tuples.IntXYZ(); position.x=readBigEndianInt(); position.y=readBigEndianInt(); position.z=readBigEndianInt();
		yaw=readBigEndianByte();
		pitch=readBigEndianByte();
		onGround=this.readBool();
	}

	public static EntityTeleport fromBuffer(byte[] buffer) {
		EntityTeleport ret = new EntityTeleport();
		ret.decode(buffer);
		return ret;
	}

	@Override
	public String toString() {
		return "EntityTeleport(entityId: " + this.entityId + ", position: " + this.position.toString() + ", yaw: " + this.yaw + ", pitch: " + this.pitch + ", onGround: " + this.onGround + ")";
	}

}
